#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-03-03

# Shortdesc: Test suite for restsh.
# Desc:
# Test suite for restsh.

# shellcheck disable=SC2034 # Variable references are used

SCRIPTPATH=$(dirname "$0")

export RESTSH_CUSTOM_ENV="$SCRIPTPATH/test.env"

RESTSH_PATH="$(realpath restsh)"
export RESTSH_PATH
export RESTSH_HOST="localhost"
unset RESTSH_INTERACTIVE
. "$RESTSH_PATH/restsh.init"

if [ "$RESTSH_CUSTOM_TEST" -ne 1 ]
then
    echo_err "Custom environment not found."
    exit 1
fi

# Set a random secret for tests
RESTSH_SECRET=$(restsh.pwgen)
export RESTSH_SECRET

# Groups of tests
declare -A ALL_GROUPS
ALL_GROUPS["aafw"]="TESTS_AAFW"
ALL_GROUPS["cert"]="TESTS_CERT"
ALL_GROUPS["f5"]="TESTS_F5"
ALL_GROUPS["f5os"]="TESTS_F5"
ALL_GROUPS["gitlab"]="TESTS_GITLAB"
ALL_GROUPS["restsh"]="TESTS_RESTSH"

. "$SCRIPTPATH/restsh.util"
. "$SCRIPTPATH/f5.common"
. "$SCRIPTPATH/mo.f5.as3"
. "$SCRIPTPATH/mo.functions"

TESTS_AAFW=()
TESTS_CERT=()
TESTS_F5=()
TESTS_F5OS=()
TESTS_GITLAB=()
TESTS_RESTSH=(
    "${TESTS_RESTSH_UTIL[@]}"
    "${TESTS_F5_COMMON[@]}"
    "${TESTS_MO_F5_AS3[@]}"
    "${TESTS_MO_FUNCTIONS[@]}"
)

# Run single test
run_test() {
    echo -n "$(basename "$1") ... "
    local RESULT
    if RESULT=$("$1" 2>&1)
    then
        echo_ok "ok"
        return 0
    fi
    echo -e "${COLOR_RED}failed${COLOR_RESET}"
    echo "--"
    echo "$RESULT"
    echo "--"
    awk '{print} END {fflush()}'
    return 1
}

# Run a group of tests
run_group() {
    declare -n GROUP="$1"
    for T in "${GROUP[@]}"
    do
        run_test "$T"
    done
}

# Get options
RUN_GROUP=""
RUN_TEST=""
while getopts ':g:t:' OPTION
do
    case "$OPTION" in
        g) RUN_GROUP=$OPTARG ;;
        t) RUN_TEST=$OPTARG ;;
        *) OPTION="invalid"; break ;;
    esac
done
shift "$((OPTIND -1))"

if [ "$OPTION" = "invalid" ]
then
    exec 1>&2
    _restsh.help.desc.get "$0"
    echo "Usage: $(basename "$0") [options ...]"
    echo "Options"
    echo "    -g <group>  Group of tests: ${!ALL_GROUPS[*]}"
    echo "    -t <test>   Test, the scriptname"
    exit 2
fi

if [ -n "$RUN_TEST" ]
then
    # Run single test
    run_test "$RUN_TEST"
elif [ -n "$RUN_GROUP" ]
then
    # Run a group of tests
    if [ -z "${ALL_GROUPS[$RUN_GROUP]:-}" ]
    then
        echo_err "Empty group"
        exit 1
    fi
    run_group "${ALL_GROUPS[$RUN_GROUP]}"
else
    # Run all tests from all groups
    for G in "${ALL_GROUPS[@]}"
    do
        run_group "$G"
    done
fi
