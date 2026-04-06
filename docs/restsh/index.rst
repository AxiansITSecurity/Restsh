Usage
=====

.. toctree::
   :glob:
   :hidden:

   Examples.rst
   GeneralFunctions/index.rst
   modules/index.rst

First read and follow the :doc:`First Steps chapter </FirstSteps/index>` to install and setup Restsh correctly.

Interactive mode
----------------

#. Start Restsh: ``restsh``
#. Select configuration to use.
#. Restsh prompts for credentials if not defined in the configuration file.
#. The prompt changes to the Restsh prompt that shows your current working directory, git branch and the configured REST endpoint.

In this mode you can use all the commands you know from your linux environment and additional special commands defined by Restsh and the loaded modules. Type ``restsh.help`` to get an overview of the configured environment and available commands.

HTTP methods
~~~~~~~~~~~~

Restsh defines the special ``DELETE``, ``GET``, ``HEAD``, ``PATCH``, ``POST``, ``PUT`` commands that connects directly to the endpoint defined by ``RESTSH_HOST``.

``GET /api/version`` translates to ``https://<rest endpoint>/api/version``. Restsh transparently handles the authentication for you.

- :doc:`HTTP functions </restsh/GeneralFunctions/Overview>`

.. hint::

   Restsh provides autocompletion for F5, GitLab and SCM REST API endpoints. Simply start typing and press ``TAB`` for completion, e. g. ``GET /mgmt/tm/``.

Scripted mode
-------------

- :doc:`Scripting </Advanced/Scripting>`

Functions
---------

-  :doc:`Functions <GeneralFunctions/index>`
-  :doc:`Modules <modules/index>`

   -  :doc:`Certificates <modules/cert/index>`
   -  :doc:`F5 TMOS <modules/f5/index>`
   -  :doc:`F5OS-A / rSeries <modules/f5osa/index>`
   -  :doc:`GitLab <modules/gitlab/index>`
   -  :doc:`Sectigo Cert Manager <modules/scm/index>`
