#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-08-01

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
