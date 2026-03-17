#!/usr/bin/env bash

# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security

# Shortdesc: Transfer a group to a new parent group.
# Desc:
# Transfer a group to a new parent group.

# Strict error handling
set -eEu -o pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
    echo "Script must be run in the restsh environment."
    exit 1
fi

# Get options
GROUP=""
while getopts ':' OPTION
do
    case "$OPTION" in
        *) OPTION="invalid"; break ;;
    esac
done
shift "$((OPTIND -1))"

if [ "$OPTION" = "invalid" ] || [ $# -ne 2 ]
then
    exec 1>&2
    _restsh.help.desc.get "$0"
    echo "Usage: $(basename "$0") <group> <new parent group>"
    exit 2
fi

restsh.util.check.string "group" "$1"; GROUP=$1
restsh.util.check.string "new parent group" "$2"; NEW_PARENT_GROUP=$2
restsh.util.check.isnumber "$GROUP" || GROUP=$(gitlab.group.id "$GROUP")
restsh.util.check.isnumber "$NEW_PARENT_GROUP" || NEW_PARENT_GROUP=$(gitlab.group.id "$NEW_PARENT_GROUP")

JQ -n --argjson new_parent_group "$NEW_PARENT_GROUP" \
    '{
        group_id: $new_parent_group
    }' | POST "$GITLAB_API_PREFIX/groups/${GROUP}/transfer"
