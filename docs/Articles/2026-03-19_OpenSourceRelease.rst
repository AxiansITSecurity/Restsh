Resth is now available under an OpenSource license!
====================================================

I am proud to announce that the complete Restsh package is now licensed under the GPL version 3 or greater. No other restrictions apply, we are not holding back any enterprise functionality and are committed to maintain and further develop it.

What is Restsh?
---------------

Restsh is a Bash shell environment to work with REST-API's on the command line. It is designed to be used interactively, in scripts or in CI/CD pipelines.

It is one of the core components of the `Axians Automation Framework <https://www.axians.de/app/uploads/sites/72/2025/10/Axians-Automation-Framework_web.pdf>`_, which enables the automation of F5 environments using GitLab CI/CD pipelines.

Restsh is not a standalone shell. It sets only some environment variables and defines helper functions to access and parse REST-API's. You can combine the power of Bash, Curl, Jq and Mustache to interact with REST-API's.

What can I do with it?
----------------------

All what you imagine. Restsh supports all common REST-API verbs and has autocompletion for the F5 and GitLab REST-API. To make it easier there are hundreds of small helper scripts that are wrapping the REST-API endpoints. These functions are based on the central Unix principle: Do one job as good as possible.

You can take this simple scripts, pipe the output from one script into an another, filter the output or place it in a loop. For example, with Restsh it is a simple one-liner to export all WAF-Policies from a F5: ``f5.asm.policy.list -r -f ".items[].fullPath" | XARGS f5.asm.policy.export``

Restsh is modular and ships many functions to interact with the REST-API's from F5 BIG-IP, F5 OS-A and GitLab.

- `F5 functions <https://axiansitsecurity.github.io/Restsh/restsh/modules/f5/overview.html>`_
- `F5 OS-A functions <https://axiansitsecurity.github.io/Restsh/restsh/modules/f5osa/index.html>`_
- `GitLab functions <https://axiansitsecurity.github.io/Restsh/restsh/modules/gitlab/overview.html>`_

Do I have to sell my soul to get it?
------------------------------------

Restsh is public available and can be downloaded from the official and public `GitHub repository <https://github.com/AxiansITSecurity/Restsh>`_.

Support?
--------

This is the OpenSource and community supported version of Restsh. You can book enterprise-grade support from Axians IT Security GmbH. Simply write an email to <juergen.mang@sec.axians.de> to get in contact.

The documentation is `online available <https://axiansitsecurity.github.io/Restsh/>`_.
