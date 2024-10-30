#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-10-30

# Shortdesc: Creates a archive with all components.
# Desc:
# Creates an archive with all components, excludes git history.

# Strict error handling
set -eEuo pipefail

VERSION=$(<restsh/version)

tar -czf "restsh_${VERSION}.tgz" -- \
    restsh .restsh-config.dist* *.md
