Examples
========

Common GitLab examples for managing GitLab project, groups, etc. through Restsh.

Groups
------

Simple group management
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sh

    # List all groups
    gitlab.group.list

    # Get details of a specific group
    gitlab.group.get test/example/subgroup

    # Create a new group
    gitlab.group.create -p test newgroup

    # Mark a group for deletion
    gitlab.group.delete test/newgroup

    # Delete a group immediately (use with caution)
    gitlab.group.purge test/newgroup

Clone a GitLab group recursively
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This clones a GitLab group recursively and maps the project paths to filesystem paths.

.. code:: sh

    gitlab.group.clone test/example/subgroup

Projects
--------

Simple project management
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sh

    # List all projects in a group
    gitlab.group.projects test/example/subgroup

    # Get details of a specific project
    gitlab.project.get test/example/project

    # Create a new project
    gitlab.project.create test/example project

    # Mark a project for deletion
    gitlab.project.delete test/example/project

    # Delete a project immediately (use with caution)
    gitlab.project.purge test/example/project
