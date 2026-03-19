#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Reference: https://cheatsheetseries.owasp.org/cheatsheets/XS_Leaks_Cheat_Sheet.html#cross-origin-opener-policy-coop

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

# OK
case "$VALUE" in
    "same-origin-allow-popups") exit 0 ;;
    "same-origin") exit 0 ;;
esac

# Invalid value
echo "Invalid or unsafe value"
exit 1
