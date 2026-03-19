#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Reference: https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/TLS#http_strict_transport_security_implementation

read -r VALUE

# Header should be present
if [ "$VALUE" = "<NOTFOUND>" ]
then
    echo "Not found"
    exit 1
fi

AGE=$(sed -E 's/.*max-age=([[:digit:]]+).*/\1/' <<< "$VALUE")

# OK
if [ "$AGE" -ge 15768000 ]
then
    exit 0
fi

# Invalid value
echo "Max-age should be at least six months."
exit 1
