#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-07-04

# Shortdesc: Bash autocompletion for F5 Next API.
# Desc:
# Bash autocompletion for F5 Next API.

_method() {
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local opts=""
    case "$prev" in
        DELETE|GET|PATCH|POST|PUT)
            opts=$(sed -E "s|($cur[^/]+/).*|\1|" "$RESTSH_PATH/autocomplete/next/method_$prev" | sort -u)
            ;;
    esac

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

complete -o nospace -F _method DELETE
complete -o nospace -F _method GET
complete -o nospace -F _method PATCH
complete -o nospace -F _method POST
complete -o nospace -F _method PUT
