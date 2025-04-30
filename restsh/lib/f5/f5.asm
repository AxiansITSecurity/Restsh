#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-05-02

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

# Gets the id of signature for a policy by global signatureId
f5.asm.policy.signature.getid() {
    if [ -z "${1+x}" ] || [ -z "${2+x}" ] || [ "$1" = "-h" ]
    then
        echo "Gets the id of signature for a policy by global signatureId" 1>&2
        echo "Usage: f5.asm.policy.signature.getid <policy hash> <signature id>" 1>&2
        return 2
    fi
    local POLICY_HASH=$1
    local GETID=$2
    while read -r ID SIGNATUREID
    do
        if [ "$SIGNATUREID" = "$GETID" ]
        then
            printf "%s" "$ID"
            return 0
        fi
    done < <(GET "/mgmt/tm/asm/policies/$POLICY_HASH/signatures" \
        | JQ -r ".items[] | .id,.signatureReference.signatureId" \
        | paste - -)
    echo_err "Failure getting signature id"
    return 1
}

# Gets the signature set id
f5.asm.signatureset.getid() {
    if [ -z "${1+x}" ] || [ "$1" = "-h" ]
    then
        echo "Gets the signature set id" 1>&2
        echo "Usage: f5.asm.signatureset.getid <name>" 1>&2
        return 2
    fi
    local SIGNATURESETID
    if ! SIGNATURESETID=$(GET /mgmt/tm/asm/signature-sets?\$select=name,id | jq -r ".items[] | select(.name == \"$1\") | .id")
    then
        echo_err "Failure getting signatureset id"
        return 1
    fi
    if [ -z "$SIGNATURESETID" ] || [ "$SIGNATURESETID" = "null" ]
    then
        echo_err "Failure getting signatureset id"
        return 1
    fi
    printf "%s" "$SIGNATURESETID"
    return 0
}

# Gets the id of an ASM policy template
f5.asm.template.getid() {
    if [ -z "${1+x}" ] || [ "$1" = "-h" ]
    then
        echo "Gets the id of an ASM policy template" 1>&2
        echo "Usage: f5.asm.template.getid <template name>" 1>&2
        return 2
    fi
    local TEMPLATEID
    if ! TEMPLATEID=$(GET /mgmt/tm/asm/policy-templates | JQ -r '.items[] | select(.name == "'"$1"'") | .id')
    then
        echo_err "Failure getting template id"
        return 1
    fi
    if [ -z "$TEMPLATEID" ] || [ "$TEMPLATEID" = "null" ]
    then
        echo_err "Failure getting template id"
        return 1
    fi
    printf "%s" "$TEMPLATEID"
    return 0
}

# Calculates the hash of a F5 ASM Policy fullPath.
f5.asm.policy.gethash() {
    if [ -z "${1+x}" ] || [ "$1" = "-h" ]
    then
        echo "Calculates the hash of a F5 ASM Policy fullPath." 1>&2
        echo "Usage: f5.asm.policy.gethash <policy fullPath>" 1>&2
        return 2
    fi
    local POLICY=$1
    # Calculate hash
    if [ "${POLICY:0:1}" == "/" ]
    then
        # Reference: https://my.f5.com/manage/s/article/K40414407
        printf "%s" "$POLICY" | openssl dgst -md5 -binary | base64 | cut -c-22 | sed 'y/+\//-_/'
    else
        echo_err "Policy fullPath must start with /"
        return 1
    fi
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

export -f f5.asm.policy.signature.getid
export -f f5.asm.signatureset.getid
export -f f5.asm.template.getid
export -f f5.asm.policy.gethash
export -f f5.asm.taskwait
