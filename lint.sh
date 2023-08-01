#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-08-01

# Shortdesc: Lints the scripts with shellcheck.
# Desc:
# Lints the scripts with shellcheck.

# Strict errorhandling
set -eEuo pipefail

SHELLCHECK_OPT="--severity=warning"
FILES_TO_CHECK1=(restsh/restsh.*)
FILES_TO_CHECK2=$(find restsh/lib restsh/bin -type f ! -name .\*)

xargs shellcheck "$SHELLCHECK_OPT" -- <<< "${FILES_TO_CHECK1[*]} ${FILES_TO_CHECK2[*]}" 

echo "OK! Shellcheck does not report any warnings or errors"
exit 0
