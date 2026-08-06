Examples
========

Common GitLab examples for managing GitLab project, groups, etc. through RESTSH.

Groups
------

Clone a GitLab group recursively
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This clones a GitLab group recursively and maps the project paths to filesystem paths.

.. code:: sh

    gitlab.group.clone test/example/subgroup
