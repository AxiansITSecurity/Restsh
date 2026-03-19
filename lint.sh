#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security

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

for FILE in test/*
do
    if [ -f "$FILE" ]
    then
        shellcheck "${SHELLCHECK_OPT[@]}" -- "$FILE" || ERROR=1
    fi
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
