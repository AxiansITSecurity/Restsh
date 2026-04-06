Developing Restsh functions
===========================

You can place custom scripts in the ``restsh/modules/custom/bin`` or ``restsh/modules/custom/lib`` folders.

Add a ``.shortdesc`` file into the folder for a short description (read by the ``restsh.help`` command).

Scripts in the bin folder
-------------------------

Scripts in the bin folder are treated as standard scripts.

Use the following header for each script file:

.. code:: sh

   #!/usr/bin/env bash

   # Shortdesc: This line is displayed in the help.
   # Desc:
   # More detailed description.

   # Strict error handling
   set -eEu -o pipefail

   # Debug mode
   [ -n "${RESTSH_DEBUG+x}" ] && set -x

   if [ -z "${RESTSH_PATH+x}" ]
   then
       echo "Script must be run in the restsh environment." 1>&2
       exit 1
   fi

   # Begin of custom script

Scripts in the lib folder
-------------------------

Scripts in the lib folder are sourced in from ``restsh.init``. Define functions in this file and export these functions.

Use the following header for each script file:

.. code:: sh

   #!/usr/bin/env bash

   # Shortdesc: Short description
   # Desc:
   # More detailed description.

   # Strict error handling
   set -uo pipefail

   # Debug mode
   [ -n "${RESTSH_DEBUG+x}" ] && set -x

   # Description - this line is displayed in the help, only one line allowed.
   sample.func() {
       # Function body
       return 0
   }
   export -f sample.func

Temporary files
---------------

Create temporary files always in ``$RESTSH_TMP``. This is a uniq temporary directory created at startup and cleaned up on exit.

Each script should clean up its own temporary files. Use a cleanup trap to do this.

.. code:: sh

   # Cleanup tmp files on exit
   _cleanup() {
       rm -f "$RESTSH_TMP/existing.json"
       rm -f "$RESTSH_TMP/new.json"
   }
   trap _cleanup EXIT

Some further hints
------------------

- The header enables strict error checking. Handle each command that can fail and return an appropriated error code: ``0`` for success, else ``1``
- Use ``echo_err`` or ``echo_warn`` to print errors and warnings to STDERR.
- Use ``echo_verbose`` to print verbose messages. They are only printed if ``RESTSH_VERBOSE`` is set to ``1``.
- Provide usage information for all functions.
- Check your functions with `shellcheck <https://github.com/koalaman/shellcheck>`__, the ``lint.sh`` script does it for you.
