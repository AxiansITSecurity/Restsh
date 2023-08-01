#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-07-27

# Shortdesc: Creates a archive with all components.
# Desc:
# Creates an archive with all components, excludes git history.

# Strict errorhandling
set -eEuo pipefail

VERSION=$(<restsh/version)

if [ -z "${1+x}" ]
then
    MODE="usage"
else
    MODE="$1"
fi

case "$MODE" in
    minimal)
        tar -czf "restsh_min_${VERSION}.tgz" \
            --exclude=TODO.* \
            --exclude=restsh/bin/f5 \
            --exclude=restsh/templates \
            --exclude=restsh/lib/f5/f5.as3 \
            --exclude=restsh/lib/f5/f5.asm \
            --exclude=restsh/lib/mo/f5.as3 \
            -- restsh .restsh-config.dist *.md
        ;;
    complete)
        tar -czf "restsh_${VERSION}.tgz" -- restsh .restsh-config.dist *.md
        ;;
    *)
        echo "Usage: $0 <complete|minimal>"
        exit 1
        ;;
esac
