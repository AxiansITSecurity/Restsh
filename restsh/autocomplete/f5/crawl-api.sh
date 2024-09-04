#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-09-04

# Shortdesc: Crawls the F5 REST API to collect all available endpoints.
# Desc:
# Crawls the F5 REST API to collect all available endpoints.

# Strict error handling
set -eEu -o pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
    echo "Script must be run in the restsh environment."
    exit 1
fi

declare -A LINKS

get_links() {
    local BASE=$1
    local LINK
    while read -r LINK
    do
        echo "Read: $LINK" 1>&2
        case "$LINK" in
            /mgmt/tm/asm/attack-types/*) LINK="/mgmt/tm/asm/attack-types/example" ;;
            /mgmt/tm/asm/events/requests/*) LINK="/mgmt/tm/asm/events/requests/example" ;;
            /mgmt/tm/asm/incident-types/*) LINK="/mgmt/tm/asm/incident-types/example" ;;
            /mgmt/tm/asm/sections/*) LINK="/mgmt/tm/asm/sections/example" ;;
            /mgmt/tm/asm/server-technologies/*) LINK="/mgmt/tm/asm/server-technologies/example" ;;
            /mgmt/tm/asm/signature-systems/*) LINK="/mgmt/tm/asm/signature-systems/example" ;;
            /mgmt/tm/asm/signatures/*) LINK="/mgmt/tm/asm/signatures/example" ;;
            /mgmt/tm/asm/violations/*) LINK="/mgmt/tm/asm/violations/example" ;;
            /mgmt/tm/cloud/ltm/pool-members/*) LINK="/mgmt/tm/cloud/ltm/pool-members/example" ;;
            /mgmt/tm/live-update/asm-attack-signatures/update-files/*) LINK="/mgmt/tm/live-update/asm-attack-signatures/update-files/example" ;;
            /mgmt/tm/live-update/behavioral-waf/update-files/*) LINK="/mgmt/tm/live-update/behavioral-waf/update-files/example" ;;
            /mgmt/tm/live-update/bot-signatures/update-files/*) LINK="/mgmt/tm/live-update/bot-signatures/update-files/example" ;;
            /mgmt/tm/live-update/browser-challenges/update-files/*) LINK="/mgmt/tm/live-update/browser-challenges/update-files/example" ;;
            /mgmt/tm/live-update/file-transfer/downloads/*) LINK="/mgmt/tm/live-update/file-transfer/downloads/example" ;;
            /mgmt/tm/live-update/server-technologies/update-files/*) LINK="/mgmt/tm/live-update/server-technologies/update-files/example" ;;
            /mgmt/tm/net/interface/*) LINK="/mgmt/tm/net/interface/example" ;;
            /mgmt/tm/net/trunk/*) LINK="/mgmt/tm/net/trunk/example" ;;
            /mgmt/tm/sys/disk/logical-disk/*) LINK="/mgmt/tm/sys/disk/logical-disk/example" ;;
            /mgmt/tm/sys/software/volume/*) LINK="/mgmt/tm/sys/software/volume/example" ;;
            /mgmt/tm/sys/ucs/*) LINK="/mgmt/tm/sys/ucs/example" ;;
            /mgmt/*) ;;
            *) continue ;;
        esac
        if [ -z "${LINKS[$LINK]+x}" ]
        then
            LINKS[$LINK]=1
            if GET "$LINK" >/dev/null 2>&1
            then
                echo "${LINK//example/\{id\}}"
                get_links "$LINK"
                [[ "$LINK" == *example ]] || get_links "$LINK/example"
            fi
        fi
    done < <(GET -r "$BASE" 2>/dev/null \
        | jq -r ".. | .link?" \
        | grep -E -v '(~Common~|null)' \
        | sed -e 's|https://localhost||g' -e 's|\?ver=.*$||')
}

get_links "/mgmt/tm/"
