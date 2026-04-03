Docker
======

You can create your own Docker image or you can use the image from `GitHub container registry <https://github.com/orgs/AxiansITSecurity/packages?repo_name=Restsh>`_.

Create and use your own image
-----------------------------

There is a ``Dockerfile`` in the root of the Restsh repository and a helper script ``docker.sh``

.. code:: sh

    git clone https://github.com/AxiansITSecurity/Restsh.git restsh
    cd restsh
    ./docker.sh build
    ./docker.sh run


Use the image from GitHub
-------------------------

.. code:: sh

    docker pull ghcr.io/axiansitsecurity/restsh/restsh:latest
    docker run --rm -it -v "$RESTSH_CONFIG_PATH":/restsh-config --network host ghcr.io/axiansitsecurity/restsh/restsh

Restsh configuration
--------------------

The Docker image uses the path ``/restsh-config`` for configuration files. You can optionally specify the full path of configuration file to use in the ``docker run`` command, e. g. ``docker run --rm -it -v "$RESTSH_CONFIG_PATH":/restsh-config --network host ghcr.io/axiansitsecurity/restsh/restsh /restsh-config/lab/.restsh-config-f5-lab-v17-1``.

Create configuration files
~~~~~~~~~~~~~~~~~~~~~~~~~~

You must overwrite the default entrypoint.

.. code:: sh

    docker run --rm -it -v "$RESTSH_CONFIG_PATH":/restsh-config --network host --entrypoint /restsh/restsh.setup ghcr.io/axiansitsecurity/restsh/restsh
