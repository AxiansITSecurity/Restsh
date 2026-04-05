Configure
=========

Restsh requires a configuration file for each host that should be accessed via REST.

The ``restsh.setup`` script can be used to create the initial configuration files.

.. code:: sh

    restsh.setup add <type> <folder> <host>
        Type: One of f5, f5osa, gitlab
        Folder: Subfolder in the config folder
        Host: Hostname of the REST endpoint

As an alternative you can copy one of the ``.restsh-config.dist`` files in your ``.restsh-config`` folder. The filename must always start with ``.resth-config-``. All the configuration options are documented directly in this files.

To create an configuration file for your first F5 BIG-IP:

.. code:: sh

    restsh.setup add f5 lab f5-lab-v17-1.lab.lan

To create an configuration file for your GitLab instance:

.. code:: sh

    restsh.setup add gitlab lab gitlab.lab.lan

Customize
---------

After initial creation of the configuration file you can adapt it to your needs. All configuration options are documented directly in the file.

.. hint::

    The configuration files are simple shell scripts that are sourced by ``restsh.init``.

