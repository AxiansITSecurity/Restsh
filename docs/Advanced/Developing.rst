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

   # Get options
   while getopts ':h' OPTION
   do
       case "$OPTION" in
           *) OPTION="invalid"; break ;;
       esac
   done
   shift "$((OPTIND -1))"

   # Usage info on invalid options
   if [ "$OPTION" = "invalid" ] || [ $# -ne 2 ]
   then
       exec 1>&2
       _restsh.help.shortdesc.get "$0"
       echo "Usage: $(basename "$0") [options...] <argument1> <argument2>"
       echo ""
       echo "Options:"
       echo "    -a  Description"
       echo "    -b  Description"
       echo ""
       _restsh.help.desc.get "$0"
       exit 2
   fi

   # Check arguments
   restsh.util.check.string "argument1" "$1"; ARG1=$1
   restsh.util.check.filename "argument2" "$2"; ARG2=$2
   #restsh.util.check.bool "argument2" "$2"; ARG2=$2
   #restsh.util.check.uint "argument2" "$2"; ARG2=$2

   # Main

Scripts in the lib folder
-------------------------

Scripts in the lib folder are sourced from ``restsh.init``. Use this method only for central functions that must manipulate the environment or called by many scripts.

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

Define functions in this file and export these functions.

.. code:: sh

   # Description - this line is displayed in the help.
   sample.func() {
       if [ $# -ne 1 ] || [ "$1" = "-h" ]
       then
           {
               echo "Short description"
               echo "Usage: sample.func <argument1>"
            } 1>&2
            return 2
       fi
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
