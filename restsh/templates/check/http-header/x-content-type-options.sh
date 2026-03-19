#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Reference: https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/MIME_types

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

# OK
if [ "$VALUE" = "nosniff" ]
then
    exit 0
fi

# Invalid value
echo "Should be \"nosniff\""
exit 1
