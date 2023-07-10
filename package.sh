#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# restsh (c) 2023 Juergen Mang <juergen.mang@axians.de>
# https://github.com/JuergenMang/restsh

# Shortdesc: Creates a archive with all components.
# Desc:
# Creates a archive with all components, excludes git history.

# Strict errorhandling
set -euo pipefail

VERSION=$(cat restsh/version)

tar -czf "restsh_${VERSION}.tgz" -- restsh .restsh-config.dist *.md
