#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# restsh (c) 2023 Juergen Mang <juergen.mang@axians.de>
# https://github.com/JuergenMang/restsh

# Shortdesc: Lints the scripts with shellcheck.
# Desc:
# Lints the scripts with shellcheck.

# Strict errorhandling
set -eEuo pipefail

SHELLCHECK_OPT="--severity=warning"

shellcheck "$SHELLCHECK_OPT" restsh/restsh.*

find restsh/lib -type f ! -name .\* -exec shellcheck "$SHELLCHECK_OPT" {} \;
find restsh/bin -type f ! -name .\* -exec shellcheck "$SHELLCHECK_OPT" {} \;

echo "OK! Shellcheck does not report any warnings or errors"
exit 0
