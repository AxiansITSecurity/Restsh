#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

ACTION="$1"

if [ -z "$RESTSH_CONFIG_PATH" ]
then
    echo "Environment variable RESTSH_CONFIG_PATH not set"
    exit 1
fi

case "$ACTION" in
    "build")
        docker build --no-cache -t restsh .
        ;;
    "run")
        docker run --rm -it -v "$RESTSH_CONFIG_PATH":/restsh-config --network host restsh
        ;;
    *)
        echo "Runs restsh in a container."
        echo "Usage: $(basename "$0") <build|run>"
        exit 2
        ;;
esac

exit 0
