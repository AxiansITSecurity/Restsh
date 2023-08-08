#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-07-27

# Shortdesc: General functions for the F5 ASM module.
# Desc:
# General functions for the F5 ASM module.

# Strict error handling
set -uo pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

# Calculates the hash of a F5 ASM Policy fullPath.
f5.asm.policy.gethash() {
    if [ -z "${1+x}" ]
    then
        echo "Usage: $0 <policy fullPath>"
        return 1
    fi
    local POLICY=$1
    # Calculate hash
    if [ "${POLICY:0:1}" == "/" ]
    then
        # Reference: https://my.f5.com/manage/s/article/K40414407
        printf "%s" "$POLICY" | openssl dgst -md5 -binary | base64 | cut -c-22 | sed 'y/+\//-_/'
        return 0
    fi

    echo_err "Policy fullPath must start with /"
    return 1
}

# Waits for a task to be finished.
f5.asm.taskwait() {
    if [ -z "${1+x}" ] || [ -z "${2+x}" ]
    then
        echo "Usage: $0 <entity> <id>"
        return 1
    fi
    local TASK_ENTITY=$1
    local TASK_ID=$2
    echo "Waiting for task id \"$TASK_ID\" to finish."
    local COUNTER=0
    while :
    do
        sleep "$F5_TASK_CHECK_INTERVAL"
        if [ "$COUNTER" -eq "$F5_TASK_TIMEOUT" ]
        then
            echo "Timeout waiting for task."
            return 1
        fi
        COUNTER=$((COUNTER+1))
        local STATUS
        if ! STATUS=$(GET -r "/mgmt/tm/asm/tasks/$TASK_ENTITY?\$select=id,status" | \
            $RESTSH_JQ -r ".items[] | select(.id == \"$TASK_ID\") | .status")
        then
            echo "Could not get task status."
            return 1
        fi
        case "$STATUS" in
            STARTED|NEW|"")
                continue
                ;;
            COMPLETED)
                break
                ;;
            *)
                echo "Unhandled task status: $STATUS"
                # Print task result message
                GET -r "/mgmt/tm/asm/tasks/$TASK_ENTITY" | \
                    $RESTSH_JQ -r ".items | .[] | select(.id==\"$TASK_ID\") | .result.message"
                return 1
            ;;
        esac
    done
    return 0
}

export -f f5.asm.policy.gethash
export -f f5.asm.taskwait
