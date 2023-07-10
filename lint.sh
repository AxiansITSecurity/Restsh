#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# restsh (c) 2023 Juergen Mang <juergen.mang@axians.de>
# https://github.com/JuergenMang/restsh

# Shortdesc: Lints the scripts with shellcheck.
# Desc:
# Lints the scripts with shellcheck.

# Strict errorhandling
set -euo pipefail

shellcheck --severity=warning restsh/restsh.*
shellcheck --severity=warning restsh/lib/*

find restsh/bin -type f -exec shellcheck --severity=warning {} \;
