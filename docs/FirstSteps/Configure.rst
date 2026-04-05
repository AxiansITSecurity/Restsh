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

Pre-defined config files
------------------------

| Prefix | Description |
| ------ | ----------- |
| `.restsh-config.dist.f5` | F5 BIG-IP TMOS |
| `.restsh-config.dist.f5osa` | F5OS-A / rSeries |
| `.restsh-config.dist.gitlab` | GitLab |
| `.restsh-config.dist.scm` | Sectigo Cert Manager |

Customize
---------

After initial creation of the configuration file you can adapt it to your needs. All configuration options are documented directly in the file.

.. hint::

    The configuration files are simple shell scripts that are sourced by ``restsh.init``.

Custom environment variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can use the environment variable `RESTSH_CUSTOM_ENV` to define a custom file that will be sourced from `restsh.init`.

Enable modules
~~~~~~~~~~~~~~~

Modules are enabled by setting the ``RESTSH_MODULES`` array.

.. code:: sh

    RESTSH_MODULES=("aafw" "cert" "custom" "f5" "f5osa" "gitlab" "scm")

Certificate checking
~~~~~~~~~~~~~~~~~~~~

Restsh enables uses curl to communicate with the REST-APIs. Certificate checking is enabled in all default configurations. If you encounter certificate related errors you should add the signing certificate to your system trust store. Disabling certificate checking is NOT recommended, but you can set `RESTSH_CURL_INSECURE=1` in the configuration file to disable it.

Proxy
~~~~~

The easiest thing to do is not to use a proxy and allow direct connections. Restsh uses the system proxy settings (https_proxy and http_proxy environment variables) and supports basic authentication for the proxy. Simply set following variables in the configuration file:

.. code:: sh

    RESTSH_CURL_PROXY_INSECURE="0"
    RESTSH_CURL_PROXY_AUTH="basic"
    RESTSH_CURL_PROXY_USER="<user>"
    RESTSH_CURL_PROXY_PASS="<password>"

Securing passwords
~~~~~~~~~~~~~~~~~~

Sensitive values can be stored encrypted or in HashiCorp Vault, see :doc:`Passwords and Secrets </Advanced/Passwords>` for details.

Enable debugging
~~~~~~~~~~~~~~~~

Print all executed commands and enables verbose mode of curl.

.. code:: sh

    export RESTSH_DEBUG=1
    restsh/restsh.start
