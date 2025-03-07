FROM debian:stable-slim
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends \
        certbot \
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
        yq \
    && rm -rf /var/lib/apt/lists/*