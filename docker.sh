#!/usr/bin/env bash

# Author: Juergen Mang <juergen.mang@axians.de>
# Date: 2024-06-17

ACTION="$1"
CONFIG="$2"

if [ "$ACTION" = "run" ] && [ -z "$CONFIG" ]
then
    ACTION="usage"
fi

case "$ACTION" in
    "build")
        docker build -t restsh .
        ;;
    "run")
        docker run --rm -it -v ./:/restsh --entrypoint restsh/restsh/restsh.start -e RESTSH_CONFIG="restsh/$CONFIG" restsh
        ;;
    *)
        echo "Runs restsh in a container."
        echo "Usage: $(basename "$0") <build|run> [restsh-config]"
        exit 1
        ;;
esac

exit 0