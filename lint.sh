#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2023-08-01

# Shortdesc: Lints the scripts with shellcheck.
# Desc:
# Lints the scripts with shellcheck.

# Strict error handling
set -eEuo pipefail

SHELLCHECK_OPT="--severity=info"
FILES_TO_CHECK1=(restsh/restsh.*)
FILES_TO_CHECK2=$(find restsh/lib restsh/bin -type f ! -name .\*)

ERROR=0
for FILE in ${FILES_TO_CHECK1[*]} ${FILES_TO_CHECK2[*]}
do
    if ! shellcheck "$SHELLCHECK_OPT" -- $FILE
    then
        ERROR=1
    fi
done

if [ "$ERROR" -eq 0 ]
then
    echo "OK! Shellcheck does not report any warnings or errors"
    exit 0
fi

echo "Warnings or errors found"
exit 1
