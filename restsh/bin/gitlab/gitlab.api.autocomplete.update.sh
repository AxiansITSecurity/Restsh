#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-07-10

# Shortdesc: Updates the autocompletion and help from the OpenAPI file.
# Desc:
# Updates the autocompletion and help from the OpenAPI file.

# Strict error handling
set -eEu -o pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
    echo "Script must be run in the restsh environment."
    exit 1
fi

if ! RESTSH_YQ=$(command -v yq)
then
    echo_err "Command not found: yq"
    return 1
fi

OPENAPI_FILE="$RESTSH_PATH/autocomplete/gitlab/openapi.yaml"

# Fetch OpenAPI File
OPENAPI_URI="https://gitlab.com/gitlab-org/gitlab/-/raw/master/doc/api/openapi/openapi.yaml"
if ! curl -f -s --show-error -o "$OPENAPI_FILE" "$OPENAPI_URI"
then
    exit 1
fi

if [ ! -s "$OPENAPI_FILE" ]
then
    echo_err "Empty OpenAPI file"
    echo "Download: https://gitlab.com/gitlab-org/gitlab/-/raw/master/doc/api/openapi/openapi.yaml"
    echo "Save it to: $OPENAPI_FILE"
    exit 1
fi

if ! $RESTSH_YQ "." "$OPENAPI_FILE" > /dev/null 2>&1
then
    echo_err "Invalid OpenAPI file"
    exit 1
fi

METHODS=(DELETE GET PUT POST)

# Remove old files
for F in "${METHODS[@]}"
do
    rm -f "$RESTSH_PATH/autocomplete/gitlab/method_${F}"
    rm -f "$RESTSH_PATH/autocomplete/gitlab/method_${F}.tmp"
done

echo "Generating completion files"
while read -r URI
do
    while read -r METHOD
    do
        case "$METHOD" in
            delete)
                echo "${GITLAB_API_PREFIX}${URI}" >> "$RESTSH_PATH/autocomplete/gitlab/method_DELETE.tmp"
            ;;
            get)
                echo "${GITLAB_API_PREFIX}${URI}" >> "$RESTSH_PATH/autocomplete/gitlab/method_GET.tmp"
            ;;
            put)
                echo "${GITLAB_API_PREFIX}${URI}" >> "$RESTSH_PATH/autocomplete/gitlab/method_PUT.tmp"
            ;;
            post)
                echo "${GITLAB_API_PREFIX}${URI}" >> "$RESTSH_PATH/autocomplete/gitlab/method_POST.tmp"
            ;;
        esac
    done < <($RESTSH_YQ -r ".paths.\"$URI\" | keys[]"  < "$OPENAPI_FILE" 2>/dev/null)
done < <($RESTSH_YQ -r '.paths | keys | .[]' < "$OPENAPI_FILE")

echo "Sorting completion files"
for F in "${METHODS[@]}"
do
    sort -u "$RESTSH_PATH/autocomplete/gitlab/method_${F}.tmp" > "$RESTSH_PATH/autocomplete/gitlab/method_${F}"
    rm -f "$RESTSH_PATH/autocomplete/gitlab/method_${F}.tmp"
done

echo "Generating help file"
{
    while read -r URI
    do
        while read -r METHOD
        do
            case "$METHOD" in
                delete|get|put|post)
                    DESC=$($RESTSH_YQ -r ".paths.\"$URI\".$METHOD.description" < "$OPENAPI_FILE")
                    printf "%s %s\n\t%s\n" "$METHOD" "${GITLAB_API_PREFIX}$URI" "$DESC"
                ;;
            esac
        done < <($RESTSH_YQ -r ".paths.\"$URI\" | keys[]"  < "$OPENAPI_FILE" 2>/dev/null)
    done < <($RESTSH_YQ -r '.paths | keys | .[]' < "$OPENAPI_FILE")
} > "$RESTSH_PATH/autocomplete/gitlab/openapi_help.txt"
