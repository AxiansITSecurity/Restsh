#!/usr/bin/env bash

# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security

# Shortdesc: General functions for the F5 ASM module.
# Desc:
# General functions for the F5 ASM module.

# Strict error handling
set -uo pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

# All signatures in staging
export F5_ASM_SIGNATURE_FILTER_STAGING="?\$filter=performStaging+eq+true+AND+enabled+eq+true"
# All signatures that are in staging and are ready to be enforced
export F5_ASM_SIGNATURE_FILTER_READY="?\$filter=hasSuggestions+eq+false+AND+wasUpdatedWithinEnforcementReadinessPeriod+eq+false+AND+performStaging+eq+true+AND+enabled+eq+true"
# All signatures that are in staging and have learning suggestions
export F5_ASM_SIGNATURE_FILTER_SUGGESTIONS="?\$filter=hasSuggestions+eq+true+AND+performStaging+eq+true+AND+enabled+eq+true"
# All disabled signatures
export F5_ASM_SIGNATURE_FILTER_DISABLED="?\$filter=enabled+eq+false"
# All enabled and not staged signatures
export F5_ASM_SIGNATURE_FILTER_ENABLED="?\$filter=enabled+eq+true+AND+performStaging+eq+false"

# Calculates the hash of a F5 ASM Policy fullPath.
f5.asm.policy.gethash() {
    if [ -z "${1+x}" ] || [ "$1" = "-h" ]
    then
        echo "Calculates the hash of a F5 ASM Policy fullPath." 1>&2
        echo "Usage: f5.asm.policy.gethash <policy fullPath>" 1>&2
        return 2
    fi
    local POLICY=$1
    # Calculate hash from policy name
    if [ "${POLICY:0:1}" == "/" ]
    then
        # Reference: https://my.f5.com/manage/s/article/K40414407
        printf "%s" "$POLICY" | openssl dgst -md5 -binary | base64 | cut -c-22 | sed 'y/+\//-_/' | tr -d '\n'
        return 0
    fi
    # Check if it is already a base64url encoded value
    local REGEX='^[0-9a-zA-Z_-]+$'
    if [[ "$POLICY" =~ $REGEX ]]
    then
        printf "%s" "$POLICY"
        return 0
    fi
    echo_err "Policy fullPath must start with /"
    return 1
}

# Waits for a ASM task to be finished.
f5.asm.taskwait() {
    if [ -z "${1+x}" ] || [ -z "${2+x}" ] || [ "$1" = "-h" ]
    then
        echo "Waits for a ASM task to be finished." 1>&2
        echo "Usage: f5.asm.taskwait <entity> <id>" 1>&2
        return 2
    fi
    local TASK_ENTITY=$1
    local TASK_ID=$2
    echo "Waiting for task id \"$TASK_ID\" to finish." 1>&2
    local COUNTER=0
    while :
    do
        if [ "$COUNTER" -eq "$F5_TASK_TIMEOUT" ]
        then
            echo_err "Timeout waiting for task." 1>&2
            return 1
        fi
        sleep "$F5_TASK_CHECK_INTERVAL"
        COUNTER=$((COUNTER+1))
        local STATUS
        if ! STATUS=$(GET -c 5 -r "/mgmt/tm/asm/tasks/$TASK_ENTITY?\$select=id,status" | \
            $RESTSH_JQ -r ".items[] | select(.id == \"$TASK_ID\") | .status")
        then
            echo_err "Could not get task status."
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
                echo_err "Unhandled task status: $STATUS"
                # Print task result message
                GET -r "/mgmt/tm/asm/tasks/$TASK_ENTITY" | \
                    $RESTSH_JQ -r ".items | .[] | select(.id == \"$TASK_ID\")"
                return 1
            ;;
        esac
    done
    return 0
}

export -f f5.asm.policy.gethash
export -f f5.asm.taskwait
