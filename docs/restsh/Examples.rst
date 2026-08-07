Examples
========

Common Restsh usage examples for basic tasks.

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

HTTP requests
~~~~~~~~~~~~~

:doc:`All supported HTTP functions </restsh/GeneralFunctions/Overview>` can be found in the General Functions section.

GET
^^^

Send a basic HTTP GET request to an API endpoint. The output will be formatted in JSON by default. You can also use the `-r` option to see the raw HTTP response.

.. code:: sh

   GET /api/version

POST
^^^^

Send a basic HTTP POST request to an API endpoint. The output will be formatted in JSON by default. You can also use the `-r` option to see the raw HTTP response. Post data is read from STDIN. For robust json handling, see the JSON handling section below.

.. code:: sh

   # Use heredoc to send a JSON payload with the POST request
   POST /api/version <<< '{"key": "value"}'

   # Redirect a JSON file as the payload for the POST request
   POST /api/version < payload.json

   # Pipe the output of a command as the payload for the POST request
   JQ -n --arg value "test" '{"key": $value}' | POST /api/version

JSON handling
~~~~~~~~~~~~~

You can use ``jq`` command to filter, transform, and extract data from JSON responses and create JSON requests. There are two aliases available for using ``jq`` in Restsh: ``JQ`` and ``JQE``. The ``JQ`` alias behaves like ``jq``, while ``JQE`` exits with 1 on null or false.

Filter JSON data
^^^^^^^^^^^^^^^^

.. code:: sh

   GET /api/request \
      | JQ '.data[] | select(.status == "active")'

Create JSON data
^^^^^^^^^^^^^^^^

.. code:: sh

   JQ -n --arg name "test" \
      --argjson status "1" \
      '{
         "name": $name,
         "status": $status
      }'

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

More examples for using mustache templates can be found in the :doc:`Templating </Advanced/Templating/index>` section.

Modules
-------

Examples for available Restsh modules and their specific commands.

- :doc:`F5 </restsh/modules/f5/Examples>`
- :doc:`GitLab </restsh/modules/gitlab/Examples>`
- :doc:`MyF5 </restsh/modules/myf5/Examples>`
