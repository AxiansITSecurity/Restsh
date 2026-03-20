Restsh is now available under an Open Source license!
=====================================================

I am proud to announce that the complete Restsh package is now released under the GNU General Public License version 3 (GPLv3) or later. There are no hidden restrictions — we are not withholding any enterprise features. Restsh will remain actively maintained and further developed by Axians IT Security.

What is Restsh?
---------------

Restsh is a lightweight Bash-based shell environment for working with REST APIs from the command line. It was built for interactive use, for automation in scripts, and for robust execution in CI/CD pipelines.

Restsh is a core component of the `Axians Automation Framework <https://www.axians.de/app/uploads/sites/72/2025/10/Axians-Automation-Framework_web.pdf>`_, enabling automated management of F5 environments via GitLab CI/CD pipelines.

Restsh does not replace your shell. Instead it exports a small set of environment variables and provides focused helper functions to call and parse REST APIs. Combine the power of Bash, curl, jq and Mustache templates to build reliable, repeatable workflows and automation.

What can I do with it?
----------------------

Almost anything related to REST API automation. Restsh supports the common REST verbs and includes autocompletion for F5 and GitLab APIs. To simplify day-to-day tasks, it ships hundreds of small, focused helper scripts that wrap API endpoints — designed with the Unix principle in mind: do one thing well.

These compact scripts can be piped together, filtered, or executed inside loops. For example, exporting all WAF policies from an F5 is a simple one-liner:

``f5.asm.policy.list -r -f ".items[].fullPath" | XARGS f5.asm.policy.export``

Modular design
--------------

Restsh is modular and provides many functions to interact with the REST APIs of F5 BIG-IP, F5 OS-A and GitLab:

- `F5 functions <https://axiansitsecurity.github.io/Restsh/restsh/modules/f5/overview.html>`_
- `F5 OS-A functions <https://axiansitsecurity.github.io/Restsh/restsh/modules/f5osa/index.html>`_
- `GitLab functions <https://axiansitsecurity.github.io/Restsh/restsh/modules/gitlab/overview.html>`_

Do I have to sell my soul to get it?
------------------------------------

Restsh is publicly available and can be downloaded from the official `GitHub repository <https://github.com/AxiansITSecurity/Restsh>`_.

Support
-------

This is the open-source, community-supported edition of Restsh. For enterprise-grade support and SLAs, Axians IT Security GmbH offers commercial support plans. Contact us at <juergen.mang@sec.axians.de> to discuss options.

Documentation
-------------

Full documentation is available online: `https://axiansitsecurity.github.io/Restsh/ <https://axiansitsecurity.github.io/Restsh/>`_
