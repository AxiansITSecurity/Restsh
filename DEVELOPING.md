# Developing restsh functions

You can place custom scripts in the `restsh/bin` or `restsh/lib` folders. Place your scripts in a new sub-folder inside one of these folders. Sub-folders are used to group the `restsh.help` output.

Add a `.shortdesc` file into the folder for a short description (read by the `restsh.help` command).

## Scripts in the bin folder

Scripts in the bin folder are treated as standard scripts.

Use the following header for each script file:

```sh
#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Your copyright notice. I accept only pull requests with above license
# or compatible license.

# Shortdesc: This line is displayed in the help.
# Desc:
# More detailed description.

# Strict errorhandling
set -eEu -o pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

if [ -z "${RESTSH_PATH+x}" ]
then
    echo "Script must be run in the restsh environment." >&2
    exit 1
fi

# Begin of custom script
```

## Scripts in the lib folder

Scripts in the lib folder are sourced in from `restsh.init`. Define functions in this file and export these functions.

Use the following header for each script file:

```sh
#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Your copyright notice. I accept only pull requests with above license
# or compatible license.

# Shortdesc: Short description
# Desc:
# More detailed description.

# Strict errorhandling
set -uo pipefail

# Debug mode
[ -n "${RESTSH_DEBUG+x}" ] && set -x

# Description - this line is displayed in the help, only one line allowed.
sample.func() {
    # Function body
    return 0
}
export -f sample.func
```

## Some hints

- The header enables strict error checking. Handle each command that can fail and return an appropriated error code: `0` for success, else `1`
- Use `echo_err` or `echo_warn` to print errors and warnings to STDERR.
- Provide usage information if the function accepts arguments.
- Check your functions with [shellcheck](https://github.com/koalaman/shellcheck), the `lint.sh` script does it for you.
