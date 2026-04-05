F5 Module
=========

.. code:: sh

   RESTSH_MODULES=("cert" "custom" "f5")

All functions for this module are prefixed with ``f5.``.

Example configuration file: ``.restsh-config.dist.f5``

Authentication
--------------

You can use basic authentication with username and password for authentication or token based authentication.

restsh asks for username and password. If you want to integrate restsh in a pipeline script you can simply set the environment variables ``RESTSH_USER`` and ``RESTSH_PASS``.

Basic authentication
~~~~~~~~~~~~~~~~~~~~

.. code:: sh

   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="basic"

Token based authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sh

   [ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
   [ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="X-F5-Auth-Token"

Call `f5.auth.token.get` to retrieve the token. It uses the provided username and password to retrieve the token and sets the ``RESTSH_TOKEN_VALUE`` environment variable.

Device Groups
-------------

You can set RESTSH_HOST to a comma separated list of the F5 device group members management addresses.

Call ``f5.cluster.setactive`` before any other command to connect to the active F5 device.

References
----------

- `iControl Rest Home <https://clouddocs.f5.com/api/icontrol-rest/>`_
- `F5 REST API Authentication <https://clouddocs.f5.com/api/icontrol-soap/Authentication_with_the_F5_REST_API.html>`_
- `K45508216: Displaying the iControl REST table of contents <https://my.f5.com/manage/s/article/K45508216>`_

Examples
--------

- :doc:`Usage examples </restsh/modules/f5/Examples>`

List of all functions
---------------------

- :doc:`Overview of all functions </restsh/modules/f5/overview>`

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   overview.md
   *
