#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-12-17

# Shortdesc: Bash autocompletion for GitLab API.
# Desc:
# Bash autocompletion for GitLab API.

_method() {
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local opts=""
    case "$prev" in
        DELETE|GET|PATCH|POST|PUT)
            opts=$(grep -E "^${cur}[^/]+/?$" "$RESTSH_PATH/autocomplete/gitlab/method_$prev" | sort -u)
            if [ -z "$opts" ] && [ "${cur:0-1}" != "/" ]
            then
                cur="$cur/"
                opts=$(grep -E "^${cur}[^/]+/?$" "$RESTSH_PATH/autocomplete/gitlab/method_$prev" | sort -u)
            fi
            if [ -z "$opts" ]
            then
                opts=$(grep -E "^${cur}[^/]+/[^/]+/?$" "$RESTSH_PATH/autocomplete/gitlab/method_$prev" | sort -u)
            fi
            ;;
    esac
    mapfile -t COMPREPLY <<< "$opts"
}

complete -o nospace -F _method DELETE
complete -o nospace -F _method GET
complete -o nospace -F _method PATCH
complete -o nospace -F _method POST
complete -o nospace -F _method PUT
