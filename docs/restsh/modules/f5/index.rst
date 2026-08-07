F5 TMOS
=======

.. code:: sh

   RESTSH_MODULES=("cert" "custom" "f5")

All functions for this module are prefixed with ``f5.``.

Example configuration file: ``.restsh-config.dist.f5``

This module provides autocompletion for the REST API. All endpoints are starting with ``/mgmt/``.

Authentication
--------------

You can use basic or token based authentication.

See :doc:`Passwords and Secrets </Advanced/Passwords>` for storing the credentials encrypted.

.. code:: sh

   [ -n "${RESTSH_USER+x}" ] || export RESTSH_USER="<user>"
   [ -n "${RESTSH_PASS+x}" ] || export RESTSH_PASS="<password>"

Basic authentication
~~~~~~~~~~~~~~~~~~~~

.. code:: sh

   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="basic"

Token based authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sh

   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
   [ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="X-F5-Auth-Token"

Call ``f5.auth.token.get`` to retrieve the token. It uses the provided username and password to retrieve the token and sets the ``RESTSH_TOKEN_VALUE`` environment variable. The initial token is retrieved on startup and renewal is also managed by Restsh.

General usage hints
-------------------

Device Groups
~~~~~~~~~~~~~

You should do administrative tasks on the active device in a cluster. Call ``f5.cluster.setactive`` before any other command to connect to the active F5 device.

FullPath object names in URLs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FullPaths of F5 objects are including a ``/`` and they must escaped in URLs by replacing the ``/`` with a ``~``. In Bash you can do this with a simple inline variable expression: ``${VS//\//\~}``

- FullPath: ``/Common/test``
- Transformed: ``~Common~test``

References
----------

- `iControl Rest Home <https://clouddocs.f5.com/api/icontrol-rest/>`_
- `F5 REST API Authentication <https://clouddocs.f5.com/api/icontrol-soap/Authentication_with_the_F5_REST_API.html>`_
- `K45508216: Displaying the iControl REST table of contents <https://my.f5.com/manage/s/article/K45508216>`_
- `K13225405: Common iControl REST API command examples <https://my.f5.com/manage/s/article/K13225405>`_

Examples
--------

- :doc:`Usage examples </restsh/modules/f5/Examples>`

List of all functions
---------------------

- :doc:`Overview of all functions </restsh/modules/f5/Overview>`

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   Overview.md
   Examples.rst
   *
