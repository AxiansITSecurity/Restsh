#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-08-01

# Shortdesc: Lints the scripts with shellcheck.
# Desc:
# Lints the scripts with shellcheck.

# Strict error handling
set -eEuo pipefail

SHELLCHECK_OPT="--severity=info"
ERROR=0

for FILE in restsh/restsh.*
do
    shellcheck "${SHELLCHECK_OPT[@]}" -- "$FILE" || ERROR=1
done

while read -r FILE
do
    shellcheck "${SHELLCHECK_OPT[@]}" -- "$FILE" || ERROR=1
done < <(find restsh/lib restsh/bin -type f ! -name .\*)

if [ "$ERROR" -eq 0 ]
then
    echo "OK! Shellcheck does not report any warnings or errors"
    exit 0
fi

echo "Warnings or errors found"
exit 1
