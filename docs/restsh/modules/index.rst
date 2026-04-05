Modules
=======

Modules are enabled in the configuration by defining the ``RESTSH_MODULES`` array. You should only enable the modules you want to use for the specified endpoint.

.. code:: sh

   RESTSH_MODULES=("aafw" "cert" "custom" "f5" "f5osa" "gitlab" "scm")

Available modules
-----------------

+------------------------------+-----------------------------------------------+
| Prefix                       | Description                                   |
+==============================+===============================================+
| :doc:`aafw <aafw/index>`     | Axians Automation Framework specific modules. |
+------------------------------+-----------------------------------------------+
| :doc:`cert <cert/index>`     | Simple local Certificate handling.            |
+------------------------------+-----------------------------------------------+
| :doc:`f5 <f5/index>`         | F5 BIG-IP TMOS                                |
+------------------------------+-----------------------------------------------+
| :doc:`f5osa <f5osa/index>`   | F5OS-A / rSeries                              |
+------------------------------+-----------------------------------------------+
| :doc:`gitlab <gitlab/index>` | GitLab                                        |
+------------------------------+-----------------------------------------------+
| :doc:`scm <scm/index>`       | Sectigo Cert Manager                          |
+------------------------------+-----------------------------------------------+


.. toctree::
   :titlesonly:
   :hidden:

   aafw/index.rst
   cert/index.rst
   f5/index.rst
   f5osa/index.rst
   gitlab/index.rst
   scm/index.rst
