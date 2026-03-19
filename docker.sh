#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

ACTION="$1"
CONFIG="$2"

if [ "$ACTION" = "run" ] && [ -z "$CONFIG" ]
then
    ACTION="usage"
fi

case "$ACTION" in
    "build")
        docker build --no-cache -t restsh .
        ;;
    "run")
        docker run --rm -it -v "$(pwd):/restsh" --entrypoint restsh/restsh/restsh.start -e RESTSH_CONFIG="restsh/$CONFIG" restsh
        ;;
    *)
        echo "Runs restsh in a container."
        echo "Usage: $(basename "$0") <build|run> [restsh-config]"
        exit 1
        ;;
esac

exit 0
