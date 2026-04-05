#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

ACTION="$1"
shift 1

if [ -z "$RESTSH_CONFIG_PATH" ]
then
    echo "Environment variable RESTSH_CONFIG_PATH not set."
    exit 1
fi

SELINUX_STATUS=$(getenforce 2>/dev/null)
if [ "$SELINUX_STATUS" = "Enforcing" ]
then
    VOLUME_OPTS=":Z"
else
    VOLUME_OPTS=""
fi

DOCKER_OPTS=("run" "--rm" "-it" "-v" "${RESTSH_CONFIG_PATH}:/restsh-config${VOLUME_OPTS}" "--network" "host")

case "$ACTION" in
    build)
        docker build --no-cache -t restsh .
        ;;
    run)
        docker ${DOCKER_OPTS[@]} restsh "$@"
        ;;
    setup)
        docker ${DOCKER_OPTS[@]} --entrypoint /restsh/restsh/restsh.setup restsh "$@"
        ;;
    *)
        echo "Runs restsh in a container."
        echo "Usage: $(basename "$0") <build|setup|run>"
        exit 2
        ;;
esac

exit 0
