Examples
========

Common Restsh usage examples for basic requests and shell interaction.

General
-------

Basic commands and request patterns for everyday RESTSH usage.

Show help
~~~~~~~~~

Display available commands and help topics for the shell.

.. code:: sh

   restsh.help

   # F5 specific
   restsh.help f5

Simple GET request
~~~~~~~~~~~~~~~~~~

Send a basic HTTP GET request to an API endpoint. The output will be formatted in JSON by default. You can also use the `-r` option to see the raw HTTP response.

.. code:: sh

   GET /api/version

:doc:`All supported HTTP Functions </restsh/GeneralFunctions/Overview>` can be found in the General Functions section.

Create a request with mustache and post it
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Render a templated payload with mustache and submit it as a POST request.

.. code:: sh

   . "$RESTSH_PATH/dist/mo/mo"
   . "$RESTSH_PATH/lib/mo/mo.functions"
   VAR1="test"
   MO -- << EOL | POST /api/request
   {"var1": "{{VAR1}}"}
   EOL

More examples for using mustache templates can be found in the :doc:`Templating <Advances/Templating/index>` section.

Modules
-------

Examples for available Restsh modules and their specific commands.

- :doc:`F5 </restsh/modules/f5/Examples>`
- :doc:`GitLab </restsh/modules/gitlab/Examples>`
- :doc:`MyF5 </restsh/modules/myf5/Examples>`
