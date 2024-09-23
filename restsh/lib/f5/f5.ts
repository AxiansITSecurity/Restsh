#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-01-17

# Shortdesc: General functions for the F5 Telemetry Streaming module.
# Desc:
# General functions for the Telemetry Streaming AS3 module.

# Strict error handling
set -uo pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

# Returns the installed TS version
f5.ts.version() {
    if [ -n "${1+x}" ]
    then
        echo "Returns the installed TS version"
        echo "Usage: $0" 1>&2
        return 2
    fi
    GET "/mgmt/shared/telemetry/info"
}

export -f f5.ts.version
