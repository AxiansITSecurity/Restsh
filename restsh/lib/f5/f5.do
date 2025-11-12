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
    local CHECK_TASK_URI="/mgmt/shared/declarative-onboarding/task"
    local F5_TASK_TIMEOUT=180
    while :
    do
        sleep "$F5_TASK_CHECK_INTERVAL"
        COUNTER=$((COUNTER+1))
        local CODE
        if ! CODE=$(GET -c 180 -r -f ".[] | select(.id == \"$TASK_ID\") | .result.code" "$CHECK_TASK_URI" 2>/dev/null)
        then
            echo_err "Can not get task status."
            GET "$CHECK_TASK_URI/$TASK_ID"
            return 1
        fi
        if ! restsh.util.check.isnumber "$CODE"
        then
            echo_warn "Invalid return code, retrying"
            continue
        fi
        case "$CODE" in
            0|202)
                # In progress
                if [ "$COUNTER" -eq "$F5_TASK_TIMEOUT" ]
                then
                    echo_err "Timeout waiting for task."
                    return 1
                fi
                ;;
            200)
                # Success
                return 0
                ;;
            *)
                # Failure
                echo_err "Declarative onboarding task failed: $CODE"
                # Print result message from f5
                GET "$CHECK_TASK_URI/$TASK_ID"
                return 1
                ;;
        esac
    done
}

export -f f5.do.taskwait
