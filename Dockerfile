# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

FROM debian:stable-slim
RUN <<EOF
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get dist-upgrade -y
apt-get install -y --no-install-recommends \
        curl \
        gettext-base \
        git \
        jq \
        openssl \
        pandoc \
        whiptail \
        yq
rm -rf /var/lib/apt/lists/*
EOF

COPY ./restsh /restsh
ENV RESTSH_CONFIG_PATH=/restsh-config
ENV LANG=C.UTF-8
ENTRYPOINT ["/restsh/restsh.start"]
