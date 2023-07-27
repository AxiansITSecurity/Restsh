#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-07-27

# Shortdesc: Creates a archive with all components.
# Desc:
# Creates an archive with all components, excludes git history.

# Strict errorhandling
set -eEuo pipefail

VERSION=$(<restsh/version)

tar -czf "restsh_${VERSION}.tgz" -- restsh .restsh-config.dist *.md
