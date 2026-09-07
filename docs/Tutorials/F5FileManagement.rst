F5 File Management
==================

Introduction
------------

This tutorial provides a comprehensive guide to manage files on the F5 via the REST-API.

The F5 REST-API provides different endpoints for file management:

+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Description           | Method  | URI (endpoint)                                | Path on the F5              |
+=======================+=========+===============================================+=============================+
| Download a File       | GET     | /mgmt/cm/autodeploy/software-image-downloads  | /shared/images/             |
+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Upload an Image File  | POST    | /mgmt/cm/autodeploy/software-image-uploads    | /shared/images/             |
+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Upload a File         | POST    | /mgmt/shared/file-transfer/uploads            | /var/config/rest/downloads/ |
+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Download a QKView     | GET     | /mgmt/cm/autodeploy/qkview-downloads          | /var/tmp/qkviews            |
+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Download a UCS        | GET     | /mgmt/shared/file-transfer/ucs-downloads      | /var/local/ucs/             |
+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Upload ASM Policy     | POST    | /mgmt/tm/asm/file-transfer/uploads            | /var/ts/var/rest/           |
+-----------------------+---------+-----------------------------------------------+-----------------------------+
| Download ASM Policy   | GET     | /mgmt/tm/asm/file-transfer/downloads          | /var/ts/var/rest/           |
+-----------------------+---------+-----------------------------------------------+-----------------------------+

The GET method is used for downloading a file and the POST method to upload a file. Transfering files must be done with range headers, because the F5 REST-API restricts the payload size for each request. Restsh handles this transparently for you.

Initial configuration of Restsh
-------------------------------

See :doc:`First Steps <../FirstSteps/index>` for the initial configuration of Restsh.

Connect
-------

Connect to the F5 with Restsh:

- ``restsh``
- Select your F5

Upload a file
-------------

This example uses the ``/mgmt/shared/file-transfer/uploads`` endpoint that uploads files to ``/var/config/rest/downloads/`` on the F5. A download endpoint for this path does not exist.

.. code::

   # Upload test-file.txt
   f5.file.upload /mgmt/shared/file-transfer/uploads test-file.txt

This is the same as:

.. code::

   # Upload test-file.txt
   f5.file-transfer.upload test-file.txt

Get the file size
-----------------

Check if the file was uploaded by determining its size. It exits with a non-zero exit code  if the file does not exist.

.. code::

   f5.file.size /var/config/rest/downloads/test-file.txt

Remove a file
-------------

Restsh uses the ``/mgmt/tm/util/bash`` to execute a ``rm`` command.

.. code::

   # Remove the file
   f5.file.remove /var/config/rest/downloads/test-file.txt

Download a file
---------------

If the file size is specified as 0, Restsh attempts to determine the file size from the HTTP response headers. If that fails, the size must be specified.

.. code::

   f5.file.download /mgmt/cm/autodeploy/software-image-uploads test-file2.txt 0 test-file2.txt

Moving files
------------

Moving a file is done with the general ``f5.run`` function that can execute any Bash commands.

.. code::

   f5.run "mv" "/var/config/rest/downloads/test-file.txt" "/shared/images/test-file2.txt"

Summary
-------

This tutorial has covered the complete lifecycle of file management using Restsh:

Restsh makes it extremely easy to upload and download files to and from the F5 using the REST API.

**Used Restsh commands**:

- ``f5.file.upload``: Uploads a file to the F5.
- ``f5.file-transfer.upload``: Uploads a file to /var/config/rest/downloads
- ``f5.file.size``: Get the size of a file on the F5.
- ``f5.file.remove``: Deletes a file from the F5.
- ``f5.file.download``: Downloads a file from the F5.
- ``f5.run``: Runs a shell command on the F5.

References
----------

- `K41763344: Using the iControl REST interface for file upload and download management <https://my.f5.com/manage/s/article/K41763344>`__
- `Demystifying iControl REST Part 5: Transferring Files <https://community.f5.com/t5/technical-articles/demystifying-icontrol-rest-part-5-transferring-files/ta-p/286689>`__


Discuss
-------

- `GitHub discussion <https://github.com/AxiansITSecurity/Restsh/discussions/19>`__
- `F5 DevCentral <https://community.f5.com/kb/communityarticles/restsh-is-now-available-under-an-open-source-license/345860>`__
