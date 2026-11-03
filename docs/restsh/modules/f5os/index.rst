F5OS
======

.. code:: sh

   RESTSH_MODULES=("cert" "custom" "f5os")

Restsh is using the restconf port 8888 (API prefix ``/restconf``).

All functions for this module are prefixed with ``f5os.``.

Example configuration file: ``.restsh-config.dist.f5os``

Authentication
--------------

You can use basic authentication with username and password to retrieve a token for further authentication.

See :doc:`Passwords and Secrets </Advanced/Passwords>` for storing the credentials encrypted.

.. code:: sh

   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
   [ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="X-Auth-Token"
   [ -n "${RESTSH_USER+x}" ] || export RESTSH_USER="<user>"
   [ -n "${RESTSH_PASS+x}" ] || export RESTSH_PASS="<password>"

Call ``f5os.auth.token.get`` to retrieve the token. It uses the provided username and password to retrieve the token and sets the ``RESTSH_TOKEN_VALUE`` environment variable. The initial token is retrieved on startup and renewal is also managed by Restsh.

References
----------

- `F5OS - API <https://clouddocs.f5.com/api/rseries-api/rseries-api-index.html>`_

List of all functions
---------------------

- :doc:`Overview of all functions </restsh/modules/f5os/Overview>`

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   Overview.md
   *
