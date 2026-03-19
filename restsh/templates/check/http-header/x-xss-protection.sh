#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection

read -r VALUE

# Header should not be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 0
fi

if [ "$VALUE" = "0" ]
then
    echo "Disabled"
    exit 0
fi

# Invalid value
echo "Use a Content Security Policy (CSP) that disables the use of inline JavaScript."
exit 1
