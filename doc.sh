#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Shortdesc: Creates the HTML documentation.
# Desc:
# Creates the HTML documentation.

# Strict error handling
set -eEu -o pipefail

usage() {
    echo "Usage: $(basename "$0") [options...] <build|serve> <dest>"
    echo "Options:"
    echo "    -t <tmpdir>  Specify tmpdir and do not remove it on exit"
    exit 2
}

TMPDIR=""
while getopts ':' OPTION
do
    case "$OPTION" in
        *) OPTION="invalid"; break ;;
    esac
done
shift "$((OPTIND -1))"

if [ "$OPTION" = "invalid" ]
then
    usage
fi

ACTION=$1
[ $# -eq 2 ] && DOC_DEST=$2

if [ -z "$TMPDIR" ]
then
    TMPDIR=$(mktemp -d)
    trap 'rm -f -- "$TMPDIR"' EXIT
fi
OUTDIR="$TMPDIR/docs/restsh"

###############################################################################
# Create Restsh doc from help

cp -a docs "/$TMPDIR/"
cp -v CHANGELOG.md "$TMPDIR/docs/"
cp -v LICENSE.md "$TMPDIR/docs/"

export RESTSH_HOST=""
export RESTSH_AUTH="anonymous"
export RESTSH_PATH="restsh"
. "${RESTSH_PATH}/restsh.init"

export RESTSH_AAFW_ART=""

module_help() {
    local MODULE=$1
    mkdir -p "$OUTDIR/modules/$MODULE"
    cat > "$OUTDIR/modules/$MODULE/Overview.md" << EOL
# Overview

| Function | Description |
| -------- | ----------- |
EOL
    # Print overview table
    _restsh.help.modules.cmds "$MODULE" \
        | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }' >> "$OUTDIR/modules/$MODULE/Overview.md"
    # Print usage of each function
    local FUNCS FUNC
    FUNCS=$(_restsh.help.modules.cmds "$MODULE" | grep "$MODULE\." | awk '{print $1}')
    for FUNC in $FUNCS
    do
        {
            echo "# $FUNC"
            echo ""
            echo '```'
            "$FUNC" -h 2>&1 || true
            echo '```'
        } > "$OUTDIR/modules/$MODULE/$FUNC.md"
    done
}

module_help "f5"
module_help "f5osa"
module_help "gitlab"
module_help "scm"
module_help "cert"
module_help "aafw"

restsh_help() {
    # Print overview table
    _restsh.help.restsh.cmds \
        | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }'
    # Print usage of each function
    local FUNCS FUNC
    FUNCS=$(_restsh.help.restsh.cmds | grep "restsh\." | awk '{print $1}')
    for FUNC in $FUNCS
    do
        {
            echo "# $FUNC"
            echo ""
            echo '```'
            "$FUNC" -h 2>&1 || true
            echo '```'
        } > "$OUTDIR/GeneralFunctions/$FUNC.md"
    done
}

general_help() {
    local LIB=$1
    local FUNCS FUNC
    declare -A CMDS
    _restsh.help.parse.lib "$LIB"
    FUNCS=$(_restsh.help.print | awk '{print $1}')
    for FUNC in $FUNCS
    do
        {
            echo "# $FUNC"
            echo ""
            echo '```'
            "$FUNC" -h 2>&1 || true
            echo '```'
        } > "$OUTDIR/GeneralFunctions/$FUNC.md"
    done
    unset CMDS
}

{
    cat << EOL
# General Functions

## HTTP Functions

| Function | Description |
| -------- | ----------- |
EOL
    declare -A CMDS
    _restsh.help.parse.lib "$RESTSH_PATH/lib/restsh.http"
    _restsh.help.print | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }'
    unset CMDS

    cat << EOL

## Utility Functions

| Function | Description |
| -------- | ----------- |
EOL
    declare -A CMDS
    _restsh.help.parse.lib "$RESTSH_PATH/lib/restsh.util"
    _restsh.help.print | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }'
    unset CMDS

    cat << EOL

## Restsh Functions

| Function | Description |
| -------- | ----------- |
EOL
    restsh_help

    cat << EOL

## Vault Functions

| Function | Description |
| -------- | ----------- |
EOL
    declare -A CMDS
    _restsh.help.parse.lib "$RESTSH_PATH/lib/restsh.vault"
    _restsh.help.print | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }'
    unset CMDS
} > "$OUTDIR/GeneralFunctions/Overview.md"

general_help "$RESTSH_PATH/lib/restsh.http"
general_help "$RESTSH_PATH/lib/restsh.util"
general_help "$RESTSH_PATH/lib/restsh.vault"

get_function_desc() {
    local TITLE=$1
    local FILE=$2
    declare -A CMDS
    _restsh.help.parse.lib "$FILE"
    echo "## $TITLE"
    echo ""
    local K LINE
    for K in "${!CMDS[@]}"
    do
        echo "### $K"
        echo ""
        while read -r LINE
        do
            if [ "${LINE:0:6}" = "Usage:" ]
            then
                echo '```'
                echo "$LINE"
                echo '```'
            else
                echo "$LINE"
            fi
        done < <(sed -E 's/\t//g' <<< "${CMDS["$K"]}")
        echo ""
    done
    unset CMDS
}

{
    cat << EOL
# Functions

EOL
    get_function_desc "General" "$RESTSH_PATH/lib/mo/mo.functions"
    get_function_desc "AS3" "$RESTSH_PATH/lib/mo/mo.f5.as3"
} > "$TMPDIR/docs/Advanced/Templating/functions.md"

###############################################################################
# Install and run Sphinx

python3 -m venv "$TMPDIR/python-venv/"
$TMPDIR/python-venv/bin/python3 -m pip install --upgrade pip
$TMPDIR/python-venv/bin/pip install sphinx sphinx-book-theme sphinx-copybutton myst-parser sphinx-lint
case "$ACTION" in
    build)
        [ $# -eq 2 ] || usage
        $TMPDIR/python-venv/bin/sphinx-build -M html "$TMPDIR/docs" "$DOC_DEST"
        ;;
    lint)
        $TMPDIR/python-venv/bin/sphinx-lint "$TMPDIR/docs"
        ;;
    serve)
        [ $# -eq 2 ] || usage
        $TMPDIR/python-venv/bin/pip install sphinx-autobuild
        $TMPDIR/python-venv/bin/sphinx-autobuild -M html "$TMPDIR/docs" "$DOC_DEST"
        ;;
    *)
        usage
esac
