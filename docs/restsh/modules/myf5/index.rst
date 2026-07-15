MyF5 API
========

The MyF5 API offering is currently in a closed beta state. Contact your F5 representative and ask for access.

.. code:: sh

   RESTSH_MODULES=("cert" "custom" "myf5")

All functions for this module are prefixed with ``myf5.``.

Example configuration file: ``.restsh-config.dist.myf5``

Authentication
--------------

The MyF5 API uses OAuth2 based authentication. You must create a client id and client secret for your account.

See :doc:`Passwords and Secrets </Advanced/Passwords>` for storing the credentials encrypted.

.. code:: sh

   [ -n "${RESTSH_HOST+x}" ] || export RESTSH_HOST="support.apis.f5.com"
   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
   [ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
   [ -n "${MYF5_CLIENTID+x}" ] || export MYF5_CLIENTID=""
   [ -n "${MYF5_SECRET+x}" ] || export MYF5_SECRET=""

References
----------

- `API Catalog - Access the full range of our API offerings <https://my.f5.com/manage/s/api-catalog-getting-started>`__
- `Getting Started - Overview guide to help you quickly begin using our APIs <https://my.f5.com/manage/s/api-catalog-getting-started>`__
- `API Documentation - Detailed documentation and specifications for our APIs <https://my.f5.com/manage/myf5ApiReference>`__

Examples
--------

- :doc:`Usage examples </restsh/modules/myf5/Examples>`

List of all functions
---------------------

- :doc:`Overview of all functions </restsh/modules/myf5/Overview>`

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   Overview.md
   *
