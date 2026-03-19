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

if [ $# -ne 1 ]
then
    echo "Usage: $(basename "$1") <doc destination>"
    exit 2
fi

DOC_DEST=$1

###############################################################################
# Create Restsh doc from help

OUTDIR="docs/restsh"

cp -v ./*.md "$OUTDIR"
mv "$OUTDIR/README.md" "$OUTDIR/Usage.md"
mv "$OUTDIR/README.F5.md" "$OUTDIR/UsageF5.md"
mv "$OUTDIR/README.F5OSA.md" "$OUTDIR/UsageF5OSA.md"
mv "$OUTDIR/README.gitlab.md" "$OUTDIR/UsageGitLab.md"
mv "$OUTDIR/README.scm.md" "$OUTDIR/UsageSCM.md"

export RESTSH_HOST=""
export RESTSH_AUTH="anonymous"
export RESTSH_PATH="restsh"
. "${RESTSH_PATH}/restsh.init"

module_help() {
    local MODULE=$1
    mkdir -p "docs/restsh/modules/$MODULE"
    cat > docs/restsh/modules/$MODULE/overview.md << EOL
# Overview for $MODULE

| Function | Description |
| -------- | ----------- |
EOL
    # Print overview table
    _restsh.help.modules.cmds "$MODULE" \
        | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }' >> docs/restsh/modules/$MODULE/overview.md
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
        } > "docs/restsh/modules/$MODULE/$FUNC.md"
    done
}

module_help "f5"
module_help "f5osa"
module_help "gitlab"
module_help "scm"
module_help "cert"
module_help "aafw"
module_help "restsh"

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
        } > "docs/restsh/GeneralFunctions/$FUNC.md"
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

## Vault Functions

| Function | Description |
| -------- | ----------- |
EOL
    declare -A CMDS
    _restsh.help.parse.lib "$RESTSH_PATH/lib/restsh.vault"
    _restsh.help.print | perl -ne 'if (/^\s+(\S+)\s+(.*)$/) { print "| [$1]($1.md) | $2 |\n"; }'
    unset CMDS
} > docs/restsh/GeneralFunctions/overview.md

general_help "$RESTSH_PATH/lib/restsh.http"
general_help "$RESTSH_PATH/lib/restsh.util"
general_help "$RESTSH_PATH/lib/restsh.vault"

###############################################################################
# Install and run Sphinx

python3 -m venv /tmp/python-venv/
/tmp/python-venv/bin/python3 -m pip install --upgrade pip
/tmp/python-venv/bin/pip install sphinx sphinx-book-theme sphinx-copybutton myst-parser
/tmp/python-venv/bin/sphinx-build -M html docs "$DOC_DEST"
