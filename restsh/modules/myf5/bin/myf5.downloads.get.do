#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Shortdesc: Downloads the DO package, sha256 checksum and the schema file.
# Desc:
# Downloads the DO package, sha256 checksum and the schema file.

# Strict error handling
set -eEu -o pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
  echo "Script must be run in the restsh environment."
  exit 1
fi

myf5.endpoint.downloads

# Get options
LOCATION="USA - WEST COAST"
SHOW_ONLY=0
SLEEP=1
while getopts ':l:v' OPTION
do
    case "$OPTION" in
        l) restsh.util.check.string "location" "$OPTARG"; LOCATION=$OPTARG ;;
        v) SHOW_ONLY=1 ;;
        *) OPTION="invalid"; break ;;
    esac
done
shift "$((OPTIND -1))"

if [ "$OPTION" = "invalid" ] || [ $# -gt 1 ]
then
    exec 1>&2
    _restsh.help.desc.get "$0"
    echo "Usage: $(basename "$0") [options...] [version]"
    echo "Options:"
    echo "    -l <location>  Download location"
    echo "    -v             Show latest version download links and exit"
    echo ""
    echo "Download locations:"
    echo "    - USA - WEST COAST"
    exit 2
fi

if [ $# -eq 1 ]
then
    restsh.util.check.string "version" "$1"; VERSION=$1
else
    # Fetch latest version
    VERSION=$(GET -r "/v1/downloads-management/v1/downloads/product/DO/DO" \
        | JQ -r '[.versions[].version] | sort | reverse | .[0]')
    echo "Latest version is $VERSION"
    # Prevent Spike Arrest Policy
    sleep "$SLEEP"
fi

echo "Getting download links"
OUTPUTS=()
DOWNLOADS=()
CHECKSUM_FILE=""
while IFS=$'\t' read -r FILENAME HREF
do
    case "$FILENAME" in
        *.noarch.rpm|do-schema-*.json)
            DOWNLOADS+=("$HREF")
            OUTPUTS+=("$FILENAME")
            ;;
        *.noarch.rpm.sha256.txt)
            DOWNLOADS+=("$HREF")
            OUTPUTS+=("$FILENAME")
            CHECKSUM_FILE="$FILENAME"
            ;;
    esac
done < <(GET -r "/v1/downloads-management/v1/downloads/product/DO/DO" \
    | JQ -r ".versions[] | select(.version == \"${VERSION}\") | .containers[0].files[] | [.filename, .href] | @tsv")

COUNTER=0
for DOWNLOAD in "${DOWNLOADS[@]}"
do
    # Prevent Spike Arrest Policy
    sleep "$SLEEP"
    if [ "${DOWNLOAD:0:3}" != "/v1/" ]
    then
        DOWNLOAD="/v1${DOWNLOAD}"
    fi
    LINK=$(GET -r "${DOWNLOAD}" \
        | JQ -r ".downloadLinks[] | select(.location == \"$LOCATION\") | .href")
    if [ "$SHOW_ONLY" -eq 1 ]
    then
        echo "${OUTPUTS[$COUNTER]}: $LINK"
        echo ""
    else
        echo "Downloading ${OUTPUTS[$COUNTER]}"
        curl --show-error -o "${OUTPUTS[$COUNTER]}" "$LINK"
    fi
    COUNTER=$((COUNTER+1))
done

if [ "$SHOW_ONLY" -eq 0 ] && [ -n "$CHECKSUM_FILE" ]
then
    echo "Validating checksum"
    sha256sum -c "$CHECKSUM_FILE"
fi
