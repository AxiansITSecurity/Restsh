#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-12-17

# Shortdesc: Bash autocompletion for F5 Next API.
# Desc:
# Bash autocompletion for F5 Next API.

_method() {
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local opts=""
    local org=$cur
    local P
    while read -r P
    do
        local REGEX="^${P//\{id\}/\[^\/\]+}\$"
        if [[ $cur =~ $REGEX ]]
        then
            cur="$P"
            break
        fi
    done < "$RESTSH_PATH/autocomplete/next/method_$prev"
    case "$prev" in
        DELETE|GET|PATCH|POST|PUT)
            opts=$(grep -E "^${cur}[^/]+/?$" "$RESTSH_PATH/autocomplete/next/method_$prev" | sort -u)
            if [ -z "$opts" ] && [ "${cur:0-1}" != "/" ]
            then
                cur="$cur/"
                org="$org/"
                opts=$(grep -E "^${cur}[^/]+/?$" "$RESTSH_PATH/autocomplete/next/method_$prev" | sort -u)
            fi
            if [ -z "$opts" ]
            then
                opts=$(grep -E "^${cur}[^/]+/[^/]+/?$" "$RESTSH_PATH/autocomplete/next/method_$prev" | sort -u)
            fi
            ;;
    esac
    mapfile -t COMPREPLY < <(sed -e "s|$cur|$org|" <<< "$opts")
}

complete -o nospace -F _method DELETE
complete -o nospace -F _method GET
complete -o nospace -F _method PATCH
complete -o nospace -F _method POST
complete -o nospace -F _method PUT
