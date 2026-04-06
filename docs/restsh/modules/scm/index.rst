Sectigo Cert Manager
====================

.. code:: sh

   RESTSH_MODULES=("cert" "custom" "scm")

All functions for this module are prefixed with ``scm.``.

Example configuration file: ``.restsh-config.dist.scm``

This module provides autocompletion for the REST API. All endpoints are starting with ``/api/``.

Authentication
--------------

SCM uses OAuth2 based authentication. You must create a client id and client secret in SCM.

See :doc:`Passwords and Secrets </Advanced/Passwords>` for storing the credentials encrypted.

.. code:: sh

   [ -n "${RESTSH_HOST+x}" ] || export RESTSH_HOST="admin.enterprise.sectigo.com"
   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
   [ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
   [ -n "${SCM_CLIENTID+x}" ] || export SCM_CLIENTID=""
   [ -n "${SCM_SECRET+x}" ] || export SCM_SECRET=""

References
----------

- `Sectigo Cert Manager API <https://www.sectigo.com/knowledge-base/detail/Sectigo-Certificate-Manager-SCM-REST-API/kA01N000000XDkE>`__

List of all functions
---------------------

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   Overview.md
   *
