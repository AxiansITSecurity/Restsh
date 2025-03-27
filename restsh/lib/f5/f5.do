#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2025-01-24

# Shortdesc: General functions for the F5 Declarative Onboarding module.
# Desc:
# General functions for the F5 Declarative Onboarding module.
# https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/apidocs.html

# Strict error handling
set -uo pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

# Waits for an Declarative Onboarding task to be finished
f5.do.taskwait() {
    if [ -z "${1+x}" ] || [ "$1" = "-h" ]
    then
        echo "Waits for an Declarative Onboarding task to be finished"
        echo "Usage: f5.do.taskwait <id>" 1>&2
        return 2
    fi
    local TASK_ID=$1
    echo "Waiting for task id \"$TASK_ID\" to finish."
    local COUNTER=0
    local CHECK_TASK_URI="/mgmt/shared/declarative-onboarding/task/$TASK_ID"
    local F5_TASK_TIMEOUT=60
    local F5_TASK_CHECK_INTERVAL=20
    while :
    do
        if [ "$COUNTER" -eq "$F5_TASK_TIMEOUT" ]
        then
            echo_err "Timeout waiting for task."
            return 1
        fi
        sleep "$F5_TASK_CHECK_INTERVAL"
        COUNTER=$((COUNTER+1))
        local CODE
        if ! CODE=$(GET -c 5 -r "$CHECK_TASK_URI" | \
            $RESTSH_JQ -r ".result.code" 2>/dev/null)
        then
            # Do not fail on http errors
            continue
        fi
        local RC=0
        case "$CODE" in
            0|202)
                # In progress
                RC=$CODE
                ;;
            200)
                # ok
                RC=$CODE
                ;;
            *)
                echo_err "declarative onboarding task failed: $CODE"
                # Print result message from f5
                GET "$CHECK_TASK_URI"
                return 1
                ;;
        esac
        [ "$RC" -eq 200 ] && break
    done
    return 0
}

export -f f5.do.taskwait
