# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

FROM debian:stable-slim
RUN <<EOL
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get dist-upgrade -y
apt-get install -y --no-install-recommends \
        curl \
        gettext-base \
        git \
        gpp \
        jq \
        libxml2-utils \
        libxml-xpath-perl \
        openssh-client \
        pandoc \
        python3 \
        python3-venv \
        rpm \
        rsync \
        shellcheck \
        tcl \
        whiptail \
        yq
rm -rf /var/lib/apt/lists/*
EOL
