#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Shortdesc: Custom configuration file for restsh.init, pre-configured for Sectigo Cert Manager.
# Desc:
# Custom configuration file for restsh.init, pre-configured for Sectigo Cert Manager.
# Set central environment variables if not already set.

# Enabled modules
# shellcheck disable=SC2034
RESTSH_MODULES=("cert" "custom" "scm")

# Debugging
# export RESTSH_DEBUG="true"

# REST host to connect to
#[ -n "${RESTSH_SCHEME+x}" ] || export RESTSH_SCHEME="https"
[ -n "${RESTSH_HOST+x}" ] || export RESTSH_HOST="admin.enterprise.sectigo.com"
[ -n "${RESTSH_PORT+x}" ] || export RESTSH_PORT="443"

# Curl options
# Set this to 1 to enable curl insecure option (disables tls checks).
[ -n "${RESTSH_CURL_INSECURE+x}" ] || export RESTSH_CURL_INSECURE="0"

# Authentication settings
#[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="basic"
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
#[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="netrc"
#[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="anonymous"

# Set username/password for basic auth
#[ -n "${RESTSH_USER+x}" ] || export RESTSH_USER="apiuser"
#[ -n "${RESTSH_PASS+x}" ] || export RESTSH_PASS="apipass"

# Set token header and value
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
[ -n "${RESTSH_TOKEN_VALUE+x}" ] || export RESTSH_TOKEN_VALUE=""

# Set REST payload format
#[ -n "${RESTSH_CONTENT+x}" ] || export RESTSH_CONTENT="application/json"

# Chunk size in bytes for restsh.upload and restsh.download, default 512kB
#[ -n "${RESTSH_CHUNK_SIZE+x}" ] || export RESTSH_CHUNK_SIZE="524288"

[ -n "${SCM_ENABLE_AUTOCOMPLETE+x}" ] || export SCM_ENABLE_AUTOCOMPLETE=1

# OAuth ClientID and ClientSecret
[ -n "${SCM_CLIENTID+x}" ] || export SCM_CLIENTID=""
[ -n "${SCM_SECRET+x}" ] || export SCM_SECRET=""

# Command that is executed after initialization in interactive mode
# export RESTSH_INIT_CMD=""
