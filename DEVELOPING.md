# Developing restsh functions

You can place custom scripts in the `restsh/bin` folder. You can group your scripts in separate sub-folders.

Use the following header for each script file:

```sh
#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Your copyright notice. I accept only pull requests with above license
# or compatible license.

# Shortdesc: This line is displayed in the help
# Desc:
# Describe here the function

# Strict errorhandling
set -euo pipefail

# Debug mode
[ -n "${DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
  echo "Script must be run in the restsh environment." >&2
  exit 1
fi

# Begin of custom script
```

## Some hints

- The header enables strict error checking. Handle each command that can fail and return an appropriated error code: `exit 0` for success, else `exit 1`
- Use `echo_err` or `echo_warn` to print errors and warnings to STDERR.
- Provide usage information if the function accepts arguments.
- Check your functions with [shellcheck](https://github.com/koalaman/shellcheck), the `lint.sh` script does it for you.
