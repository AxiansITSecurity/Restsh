Scripting
=========

Restsh can be used in scripts and CI/CD pipelines. In this non-interactive mode Restsh does not prompt for credentials and fails instead. Set the credentials in the configuration file, as environment variables or even better fetch it from a :doc:`vault </Advanced/Passwords>`.

Bash Scripts
------------

Restsh can be integrated into Bash scripts. Simply export the ``RESTSH_PATH`` and source the ``restsh.init`` file.

.. code:: sh

    export RESTSH_PATH="/path/to/restsh"
    #export RESTSH_CONFIG="custom-config"
    . "$RESTSH_PATH/restsh.init"

CI/CD pipelines
---------------

If the variable ``CI_PROJECT_DIR`` is set, Restsh runs in pipeline mode. In this mode the Restsh configuration file is optional.

The Restsh configuration is normally set through CI/CD variables.

Read the :doc:`GitLab pipeline </Tutorials/GitLabPipeline>` for a step by step guide.

Call Restsh from Python
-----------------------

Restsh can be called from Python using the subprocess module. This allows you to integrate Restsh into larger Python scripts or applications.

In following example, we create a ``/tmp/restsh-commands.sh`` file that contains the Restsh commands we want to execute. We then create a wrapper script ``/tmp/restsh-wrapper.sh`` that initializes the Restsh environment and sources the commands script. Finally, we have a Python script ``/tmp/restsh-runner.py`` that executes the wrapper script, captures the output and checks the return code to determine if the command was successful.

**Commands Script**: ``/tmp/restsh-commands.sh``

.. code:: sh

    #!/usr/bin/env bash

    # Define Restsh and Bash commands to be executed
    pwd
    restsh.help

**Wrapper Script**: ``/tmp/restsh-wrapper.sh``

.. code:: sh

    #!/usr/bin/env bash

    # Initialize Restsh environment
    # The path to Restsh and the configuration file can be set through environment variables
    export RESTSH_PATH="/path/to/restsh"
    export RESTSH_CONFIG="/tmp/.restsh-config"
    . "$RESTSH_PATH/restsh.init"

    # Strict error handling
    set -eEu -o pipefail

    # Redirect stderr to stdout to capture all output from the sourced commands
    exec 2>&1

    # Simply source the file to execute the Restsh and Bash commands defined within
    . /tmp/restsh-commands.sh

**Python Script**: ``/tmp/restsh-runner.py``

.. code:: python

    #!/usr/bin/env python3

    import subprocess

    # Execute the wrapper scripts and capture the output
    result = subprocess.run("/tmp/restsh-wrapper.sh", capture_output=True, text=True)

    # Print the result of the command execution
    print(result.stdout)

    # Check if the command was successful
    if result.returncode == 0:
        print("Restsh run was successful.")
    else:
        print("Error occurred while running Restsh:")
