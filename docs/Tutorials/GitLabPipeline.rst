GitLab Pipeline
===============

Introduction
------------

This tutorial provides a comprehensive guide to create and manage GitLab projects and pipelines with Restsh. You can create the GitLab projects and pipelines themselves with Restsh while Restsh also runs inside pipeline jobs to perform REST-API tasks. This enables a self-managing automation ecosystem where Restsh controls its own deployment and configuration.

What is a pipeline?
-------------------

Traditionally a GitLab pipeline is an automated workflow that guides software through stages of building, testing, and deploying code. It consists of a series of steps called jobs, defined in a configuration file, which streamline the software delivery process.

For infrastructure automation, pipelines serve as the execution engine for infrastructure-as-code. Unlike Terraform (declarative state management) or Ansible, Restsh works directly with REST APIs, making it lightweight and ideal for environments where you need direct API control without additional management layers. Since GitLab jobs are simply Bash commands, Restsh integrates seamlessly without requiring specialized pipeline plugins or extensions.

Initial configuration of Restsh
-------------------------------

Before proceeding, ensure Restsh is installed and configured locally. See :doc:`First Steps <../FirstSteps/index>` for setup instructions and authentication configuration.

Connect
-------

Connect to GitLab with Restsh:

- ``restsh``
- Select your GitLab instance

1. Create the project
---------------------

Create a hierarchical project structure using groups and projects. Groups serve as organizational containers that inherit variables and permissions, useful for managing multiple related projects. An empty project is created in this step.

.. code:: sh

   # First: create a group for the projects
   gitlab.group.create "test-group"

   # Create the project
   gitlab.project.create "test-group/test"

   # Clone the project locally for editing
   # This uses the local git command that should be configured before.
   gitlab.project.clone "test-group/test"

1. Create your first pipeline
-----------------------------

This tutorial assumes that the GitLab Runner uses a container based `executor <https://docs.gitlab.com/runner/executors/docker/>`__. Container executors provide isolation, reproducibility, and eliminate host dependency issues.

Create a file named ``.gitlab-ci.yaml``:

.. code:: yaml

   image:
      name: docker pull ghcr.io/axiansitsecurity/restsh/restsh:latest
      entrypoint: [""] # force an empty entrypoint

   stages:
      - deploy

   variables:
      - RESTSH_AUTH: basic

   first_job:
      stage: deploy
      script:
         - "$CI_RPOJECT_DIR"/first-job.sh

.. note::
   
   ``.gitlab-ci.yaml`` is the default name for pipeline files in GitLab. This file is evaluated on each push. Pipelines can also be triggered by schedules or API calls for scheduled compliance checks or external workflows.

**Pipeline components**:

- **image**: We use the official Restsh container image.
- **stages**: We define only a deploy stage.
- **variables**: Variables for all jobs.
- **first_job**: The job definition, there can be multiple jobs.
- **script**: The shell script commands that are executed in order for this job.

For more details about pipelines read the `GitLab CI/CD pipelines documentation <https://docs.gitlab.com/ci/pipelines/>`__

1. Create the job script
------------------------

The job script initializes Restsh, enforces strict error handling, and executes tasks. Failed scripts cause the pipeline to fail, preventing partial or broken deployments.

The configuration for Restsh is stored in CI/CD variables in the next step.

Create a file named ``first-job.sh``:

.. code:: sh

   # Initialize Restsh
   . "/restsh/restsh/restsh.init"

   # Enable strict error checking
   set -eEuo pipefail

   # The pipeline should always use the active BIG-IP in a device group
   f5.cluster.setactive

   # Do some wild Restsh tasks here
   f5.status

The sourced ``restsh.init`` loads authentication and host configuration from environment variables defined in the next step. This separation keeps scripts generic and reusable across environments.

This script is called in the script section of the first_job in the pipeline.

4. Set CI/CD variables
----------------------

Store credentials and endpoints as CI/CD variables instead of hardcoding them. GitLab supports hierarchical variable scoping: group-level variables are inherited by all child projects and sub-groups, reducing duplication and enabling environment-specific overrides at the project level.


**Define shared credentials at group level (inherited by all projects)**

.. code:: sh

   # User
   gitlab.group.variable.create "test-group" "RESTSH_USER" "admin" "Restsh user"

   # Mark password as masked and hidden to prevent accidental exposure in logs
   gitlab.group.variable.create -d -m "test-group" "RESTSH_PASS" "<password>" "Restsh password"

**Project-specific variables**

.. code:: sh

   # REST-API endpoint, e.g. your F5
   gitlab.project.variable.create "test-group/test" "RESTSH_HOST" "f5-lab.lab.lan" "REST-API endpoint"

If Restsh connects to a BIG-IP device group, you can add all members to the ``RESTSH_HOST`` variable.

.. code:: sh

   # REST-API endpoint, e.g. comma separated list of BIG-IP device group members
   gitlab.project.variable.create "test-group/test" "RESTSH_HOST" "f5-lab-1.lab.lan,f5-lab-2.lab.lan" "REST-API endpoints"

5. Push your project and start the pipeline
-------------------------------------------

GitLab automatically detects .gitlab-ci.yaml, downloads the Restsh container image on the runner, and executes ``first_job``. The job inherits all CI/CD variables as environment variables.

.. code:: sh

   git add .
   git commit -m "My first pipeline"
   git push -u origin master

Monitor execution via GitLab UI or with Restsh commands:

.. code:: sh

   # Show the latest pipeline for the project
   gitlab.project.pipeline.latest "test-group/test"

   # List all jobs in the latest pipeline
   gitlab.project.pipeline.latest.jobs "test-group/test" "master"
   
   # Retrieve the full job execution log 
   gitlab.project.job.log "test-group/test" <job id>

The pipeline can also be started with Restsh.

.. code:: sh

   # Start the pipeline and wait for completion
   gitlab.project.pipeline.start -w "test-group/test" "master"

Summary
-------

This tutorial has covered the complete lifecycle of GitLab pipeline management using Restsh:

**Key takeaways**:

1. **Infrastructure as Code with Pipelines**: GitLab pipelines enable you to manage infrastructure automation through code, versioned in Git, making your infrastructure changes auditable and reproducible.
2. **Simplicity Over Complexity**: Unlike traditional IaC tools (Terraform, Ansible), Restsh integrates directly with Bash jobs, eliminating the need for complex pipeline setups while maintaining full automation capability.
3. **Self-Managing Automation:** You can use Restsh to create and manage GitLab projects and pipelines themselves, enabling a self-managing automation ecosystem where Restsh controls its own deployment.
4. **Configuration as Variables**: Separating configuration from code through CI/CD variables allows you to manage different environments (dev, staging, production) without modifying pipeline definitions.
5. **Container-Based Consistency**: Using the official Restsh container image ensures consistent behavior across different runner environments and eliminates dependency management issues.
6. **Hierarchical Variable Inheritance**: Group-level variables cascade to projects and sub-groups, reducing duplication and simplifying management of shared configuration.

**Best practices**:

- Enable strict error checking for you pipeline scripts.
- Secure sensitive data by marking CI/CD variables as both masked and hidden (-d -m flags) to prevent accidental exposure in logs.
- Implement pipeline notifications and alerts to stay informed of automation outcomes.
- Organize projects hierarchically using GitLab groups to mirror your infrastructure topology and simplify variable management at scale.
- Keep job scripts modular by separating concerns into individual scripts (e.g., first-job.sh), making them testable and reusable. 

**Next steps**:

- Explore all the possibilities for GitLab automation with Restsh.
- Create a central pipeline repository and reference it from your project pipelines.
- Use ``restsh.util.setvars`` to manage configuration in the repository itself.
- Create a GitLab structure that represents your F5 infrastructure.

**Used Restsh commands**:

- ``gitlab.group.variable.create``: Creates a group CI/CD variable
- ``gitlab.project.create``: Creates a new project
- ``gitlab.project.pipeline.latest``: Returns the latest pipelines for a projects.
- ``gitlab.project.pipeline.latest.jobs``: Lists all jobs of the latest pipeline run for a project.
- ``gitlab.project.pipeline.start``: Starts the pipeline for a project
- ``gitlab.project.job.log``: Gets a job log.
- ``gitlab.project.variable.create``: Creates a project CI/CD variable

Discuss
-------

- `GitHub discussion <https://github.com/AxiansITSecurity/Restsh/discussions/13>`__
- `F5 DevCentral <https://community.f5.com/kb/communityarticles/restsh-is-now-available-under-an-open-source-license/345860>`__
