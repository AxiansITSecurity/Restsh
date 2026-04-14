Mustache Templating
===================

.. toctree::
   :titlesonly:
   :glob:
   :hidden:

   *

This framework includes `MO <https://github.com/tests-always-included/mo>`_, a mustache template engine written in bash.

To use MO in scripts the templating engine must be sourced.

.. code:: sh

    # Include mustache
    . "${RESTSH_PATH}/dist/mo/mo"
    # Include custom Mustache functions for F5 AS3
    . "${RESTSH_PATH}/lib/mo/mo.f5.as3"
    # Include custom Mustache functions
    . "${RESTSH_PATH}/lib/mo/mo.functions"

Simple template
---------------

.. code:: sh

   VAR1="test"
   ARRAY1=("v1" "v2")
   MO -- << EOL
   {
       "var1": "{{VAR1}}",
       {{#ARRAY1}}
           {{MO_COMMA_IF_NOT_FIRST}}
           {{.}}
       {{/ARRAY1}}
   }
   EOL

Set variables
-------------

Restsh provides two helper functions to define variables from files.

- :doc:`restsh.util.setvar </restsh/GeneralFunctions/restsh.util.setvar>`
- :doc:`restsh.util.setvars </restsh/GeneralFunctions/restsh.util.setvars>`
