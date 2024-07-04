#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-07-04

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

OPENAPI_FILE="$RESTSH_PATH/autocomplete/next/openapi.json"

# Fetch OpenAPI File
#OPENAPI_URI="https://clouddocs.f5.com/cde70662-f9fe-414a-bdfd-7c6a7f99d8ed"
#if ! curl -f -s --show-error -o "$OPENAPI_FILE" "$OPENAPI_URI"
#then
#    exit 1
#fi

if [ ! -s "$OPENAPI_FILE" ]
then
    echo_err "Empty OpenAPI file"
    exit 1
fi

if ! JQ "." "$OPENAPI_FILE" > /dev/null 2>&1
then
    echo_err "Invalid OpenAPI file"
    exit 1
fi

# Remove old files
for F in delete get patch put post
do
    rm -f "$RESTSH_PATH/autocomplete/next/method_$F"
done

echo "Generating completion files"
while read -r URI
do
    while read -r METHOD
    do
        case "$METHOD" in
            delete)
                echo "$URI" >> "$RESTSH_PATH/autocomplete/next/method_DELETE"
            ;;
            get)
                echo "$URI" >> "$RESTSH_PATH/autocomplete/next/method_GET"
            ;;
            patch)
                echo "$URI" >> "$RESTSH_PATH/autocomplete/next/method_PATCH"
            ;;
            put)
                echo "$URI" >> "$RESTSH_PATH/autocomplete/next/method_PUT"
            ;;
            post)
                echo "$URI" >> "$RESTSH_PATH/autocomplete/next/method_POST"
            ;;
        esac
    done < <(JQ -r ".paths.\"$URI\" | keys[]"  < "$OPENAPI_FILE" 2>/dev/null)
done < <(JQ -r '.paths[] | ."x-f5-cm-public-api-path"' < "$OPENAPI_FILE")


echo "Generating OpenAPI help file"
desc() {
    DESC=$(JQ -r ".paths.\"$URI\".$METHOD.description" < "$OPENAPI_FILE")
    printf "%s %s\n\t%s\n" "$METHOD" "$URI" "$DESC"
}

{
    while read -r URI
    do
        while read -r METHOD
        do
            case "$METHOD" in
                delete)
                    desc
                ;;
                get)
                    desc
                ;;
                patch)
                    desc
                ;;
                put)
                    desc
                ;;
                post)
                    desc
                ;;
            esac
        done < <(JQ -r ".paths.\"$URI\" | keys[]"  < "$OPENAPI_FILE" 2>/dev/null)
    done < <(JQ -r '.paths[] | ."x-f5-cm-public-api-path"' < "$OPENAPI_FILE")
} > "$RESTSH_PATH/autocomplete/next/openapi_help.txt"
