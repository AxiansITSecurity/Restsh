F5OS-A
======

.. code:: sh

   RESTSH_MODULES=("cert" "custom" "f5osa")

Restsh is using the restconf port 8888 (API prefix ``/restconf``).

All functions for this module are prefixed with ``f5osa.``.

Example configuration file: ``.restsh-config.dist.f5osa``

Authentication
--------------

You can use basic authentication with username and password to retrieve a token for further authentication.
Restsh asks for username and password to retrieve the token. If you want to integrate restsh in a pipeline script you can simply set the environment variables ``RESTSH_USER`` and ``RESTSH_PASS``.

.. code:: sh

   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
   [ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="X-Auth-Token"

Call ``f5osa.auth.token.get`` to retrieve the token. It uses the provided username and password to retrieve the token and sets the ``RESTSH_TOKEN_VALUE`` environment variable.

References
----------

- `F5OS-A/F5 rSeries - API <https://clouddocs.f5.com/api/rseries-api/rseries-api-index.html>`_

List of all functions
---------------------

- :doc:`Overview of all functions </restsh/modules/f5osa/Overview>`

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   Overview.md
   *
