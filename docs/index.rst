Restsh
======

.. toctree::
   :hidden:

   FirstSteps/index.rst
   restsh/index.rst
   Advanced/index.rst
   CHANGELOG.md
   LICENSE.md

Restsh is a lightweight Bash-based shell environment for working with REST APIs from the command line. It was built for interactive use, for automation in scripts, and for robust execution in CI/CD pipelines. It is a core component of the `Axians Automation Framework <https://www.axians.de/app/uploads/sites/72/2025/10/Axians-Automation-Framework_web.pdf>`_, enabling automated management of F5 environments via GitLab CI/CD pipelines.

Restsh does not replace your shell. It transforms the Bash shell into a powerful commandline to access REST-API's and parse the responses. You can combine the power of bash, curl, jq and mustache to interact with REST-API's.

Restsh provides fast, direct, scriptable REST API operations without overhead. With Restsh, tasks that would otherwise require writing a Terraform module or an Ansible role can often be completed in minutes and just a few lines of script.

The provided modules are offering hundreds of API wrapper scripts to simplify the use of REST APIs. If no script is available, the API can be accessed directly using GET, DELETE, PATCH, POST, etc. It is also easy to write your own API wrapper scripts.

Restsh is published under the :doc:`GPLv3+ license <LICENSE>` in the hope that others will find it useful and make use of it.

- `Download <https://github.com/AxiansITSecurity/Restsh>`_ the source code from the official GitHub repository.
- `Discuss <https://github.com/AxiansITSecurity/Restsh/discussions>`_ and stay in contact with the community.
- `Report issues <https://github.com/AxiansITSecurity/Restsh/issues>`_

.. figure:: /_assets/restsh.svg

.. note::

   This is the OpenSource and community supported version of Restsh. You can book enterprise-grade support from Axians IT Security GmbH. Simply write an email to <juergen.mang@sec.axians.de> to get in contact.
