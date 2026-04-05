Scripting
=========

Restsh can be integrated into scripts. Simply export the RESTSH_PATH and source the ``restsh.init`` file.

.. code:: sh

    export RESTSH_PATH="/path/to/restsh"
    #export RESTSH_CONFIG="custom-config"
    . "$RESTSH_PATH/restsh.init"

In this non-interactive mode Restsh does not prompt for passwords and fails instead.

CI/CD pipelines
---------------

If the variable ``CI_PROJECT_DIR`` is set, Restsh runs in pipeline mode. In this mode the Restsh configuration file is optional.

The Restsh configuration is normally set through CI/CD variables.
