#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-07-26

# Shortdesc: Bash autocompletion for Sectigo API.
# Desc:
# Bash autocompletion for Sectigo API.

_method() {
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local opts=""
    case "$prev" in
        DELETE|GET|PATCH|POST|PUT)
            local escaped
            escaped=$(sed -E 's/\{([^}]+)\}/\\\{\1\\\}/g' <<< "$cur")
            opts=$(sed -E "s|(${escaped}[^/]+/).*|\1|" "$RESTSH_PATH/autocomplete/sectigo/method_$prev" | sort -u)
            ;;
    esac
    mapfile -t COMPREPLY < <(compgen -W "${opts}" -- "${cur}")
}

complete -o nospace -F _method DELETE
complete -o nospace -F _method GET
complete -o nospace -F _method PATCH
complete -o nospace -F _method POST
complete -o nospace -F _method PUT
