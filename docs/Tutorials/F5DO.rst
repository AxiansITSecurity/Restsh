F5 Declarative Onboarding (DO)
==============================

Introduction
------------

This tutorial provides a comprehensive guide to managing F5 BIG-IP Declarative Onboarding (DO) declarations using Restsh. It is designed for network and infrastructure engineers who need to programmatically deploy BIG-IP systems at scale.

What is Declarative Onboarding?
-------------------------------

Declarative Onboarding (DO) simplifies the initial setup and configuration of F5 BIG-IP systems. It's designed to make onboarding faster, more consistent, and less error-prone by using a declarative approach rather than requiring manual or imperative scripting.

Key features of DO:

- **Declarative syntax**: Define desired state in JSON format, not imperative steps
- **REST API driven**: Full programmatic control via HTTP/REST endpoints
- **Version-controlled configurations**: Treat infrastructure as code
- **Atomic deployments**: Ensure consistent, all-or-nothing changes

DO operates through the F5 iAppsLX framework and exposes endpoints under ``/mgmt/shared/declarative-onboarding/``.

For complete API reference and examples, see:

- `F5 BIG-IP Declarative Onboarding Documentation <https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/>`__

Common Use Cases
----------------

- Automating BIG-IP setup in cloud deployments
- Standardizing configurations across multiple devices
- Reducing human error during initial system onboarding
- Integrating with CI/CD pipelines and orchestration platforms
- Enabling Infrastructure-as-Code workflows

F5 Declarative Onboarding is part of F5's broader automation framework and is typically used alongside other F5 tools like Application Services (AS3) for more complete automation workflows.

Initial configuration of Restsh
-------------------------------

See :doc:`First Steps <../FirstSteps/index>` for the initial configuration of Restsh.

Connect
-------

Connect to the F5 with Restsh:

- ``restsh``
- Select your F5

1. Install or update DO
-----------------------

Before you can use DO to bootstrap your F5 BIG-IP system, you must install the DO extension package. The DO extension is distributed as an RPM  file through the official F5 support portal.

**Prerequisites**:

- Access to `myF5 <https://my.f5.com>`__ with valid F5 support credentials
- Administrator or sufficient privileges on the F5 BIG-IP system
- Network connectivity from your management system to the F5 BIG-IP

.. note::

   The GitHub repository for DO is no longer actively maintained. Always download the official RPM from myF5 to ensure you have the latest DO package.

**Installation steps**:

1. Download the DO RPM file from myF5 to your local system or upload it to the F5 system
2. Execute the installation command:

   .. code:: sh

      f5.pkg.install <rpm file>

**Verification**:

After installation, verify that DO is properly installed and functional:

.. code:: sh

   # List all installed iAPPsLX packages
   # This command shows all extended packages currently deployed on the system
   f5.pkg.list

   # Display DO package information
   # Shows version, build number, and deployment status
   f5.do.info

Once the installation is confirmed, you can proceed to create and manage DO declarations.

2. Create your first Declaration
--------------------------------

**Creating a declaration file**:

You need to create a JSON declaration file that contains the complete onboarding configuration. The declaration must conform to the `DO JSON schema <https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/schema-reference.html>`_.

.. hint::

   The schema on GitHub is no longer up-to-date. You can fetch the current schema file directly from your f5: ``f5.do.schema > do-schema.json``

**Example: onboarding.json**

.. code:: json

   {
    "$schema": "https://raw.githubusercontent.com/F5Networks/f5-declarative-onboarding/refs/heads/main/src/schema/latest/base.schema.json",
    "schemaVersion": "1.46.0",
    "class": "Device",
    "async": true,
    "Common": {
        "class": "Tenant",
        "mySystem": {
            "class": "System",
            "hostname": "bigip.example.com",
            "cliInactivityTimeout": 1200,
            "consoleInactivityTimeout": 1200,
            "autoPhonehome": false
        }
      }
   }

**Declaration components**:

- **$schema**: URL to the official DO JSON schema for validation
- **class: Device**: Identifies this as a DO declaration
- **async**: Set to true for asynchronous deployment
- **Common**: Default tenant for common configurations
- **mySystem**: System configuration within the tenant

**Validation and deployment**:

.. code:: sh

   # Validate JSON syntax
   # This ensures the file is valid JSON before submission
   restsh.util.json_validate < onboarding.json

   # Deploy the declaration to the F5 system
   f5.do.declare onboarding.json

After deployment, DO translates the JSON declaration into native F5 BIG-IP configuration objects.

.. hint::

   Use the following command on your BIG-IP to monitor the status of the deployment:

   .. code:: sh

      tail -F /var/log/restnoded/restnoded.log

   The deployment can take a while depending on the complexity of the declaration and the system resources. Look for a log entry "Onboarding complete." that indicates successful application of the declaration. If an error occurs, it will be logged in the same file and the declaration is rolled back to the previous state.

3. Get Declaration
------------------

To retrieve the current DO declaration from the F5 system, use the following command:

.. code:: sh

   # Get the current DO declaration
   # This shows the active configuration as JSON
   f5.do.get

4. Reset Onboarding state
-------------------------

If you need to reset the onboarding state of the F5 system (for example, to start fresh after a failed deployment), you can use the following command:

.. code:: sh

   # Reset the onboarding state
   # This clears the onboarding configuration and allows for a fresh start
   f5.do.get.id
   f5.do.reset <id>

5. Templating
-------------

For managing multiple similar deployments or creating reusable configuration patterns, Restsh integrates the Mustache template engine. This allows you to parameterize DO declarations using variables that are substituted at deployment time.

For detailed templating information, see: :doc:`Templating </Advanced/Templating/index>`

**Benefits of templating**:

- **Reusability**: Define configuration patterns once, deploy many times with different parameters
- **Maintainability**: Store common configuration logic in templates
- **Consistency**: Ensure standardized deployments across environments
- **Infrastructure as Code**: Parameterize infrastructure for different environments (dev, staging, production)
- **Reduced errors**: Eliminate manual value substitution

**Template syntax**:

Replace hardcoded values in your declaration with Mustache variables using ``{{VARIABLE_NAME}}`` syntax.

**Example template: test-tenant.tmpl**

.. code:: json

   {
    "$schema": "https://raw.githubusercontent.com/F5Networks/f5-declarative-onboarding/main/src/schema/latest/do.schema.json",
    "schemaVersion": "1.0.0",
    "class": "Device",
    "async": true,
    "Common": {
        "class": "Tenant",
        "mySystem": {
            "class": "System",
            "hostname": "{{VAR_HOSTNAME}}",
            "cliInactivityTimeout": 1200,
            "consoleInactivityTimeout": 1200,
            "autoPhonehome": false
        }
      }
   }

**Variable file: test-tenant.var**

Create a separate file containing variable assignments:

.. code:: sh

   # Define template variables
   # These values will be substituted into the template during deployment
   VAR_HOSTNAME="bigip.example.com"

**Deployment with templating**:

Deploy a templated declaration by specifying the template flag and variable file:

.. code:: sh

   # Deploy with template processing
   # -t flag: Enable template mode
   # -d flag: Specify the variable file to read substitutions from
   f5.do.declare -t -d test-tenant.var test-tenant.tmpl

**Templating workflow**:

1. Create a template file (.tmpl) with Mustache variables
2. Create a variable file (.var) with substitution values
3. Deploy using the -t and -d flags to process the template
4. Restsh substitutes variables and deploys the resulting declaration
5. Repeat with different variable files for different deployments

Summary
-------

This tutorial has covered the complete lifecycle of DO declaration management using Restsh:

**Key takeaways**:

1. **DO fundamentals**: DO enables initial configuration of F5 BIG-IP systems through REST APIs and JSON declarations.
2. **Installation**: Download and install the DO extension RPM from myF5, then verify installation using package management commands.
3. **Declaration creation**: Define system configurations in JSON declarations that conform to the DO schema, then deploy to create tenants on the F5 system.
4. **Management operations**: Use dedicated commands to get or reset the declaration.
5. **Templating**: Leverage Mustache templates to parameterize declarations and enable reusable configuration patterns across multiple deployments.

**Best practices**:

- Maintain version control for all declaration and template files
- Validate all declarations in a pre-production environment before deploying to production
- Use templates for multi-environment deployments to ensure consistency
- Document variable files and their purpose for operational clarity
- Backup existing declarations before performing updates

**Next steps**:

- Explore advanced DO features such as cluster creation, and so on
- Integrate DO deployments into CI/CD pipelines for automated infrastructure provisioning
- Review the official F5 DO documentation for comprehensive API reference and advanced use cases
- Implement Restsh templating for multi-environment deployments (development, staging, production)

**Used Restsh commands**:

- ``f5.pkg.install``: Installs an iAPPsLX package
- ``f5.pkg.list``: Lists all iAPPsLX package
- ``f5.do.declare``: Posts a declaration
- ``f5.do.get``: Gets currently deployed declaration
- ``f5.do.get.id``: Gets currently deployed declaration id
- ``f5.do.info``: Shows the installed DO version
- ``f5.do.reset``: Resets the declaration
- ``f5.do.schema``: Fetches the DO schema
- ``restsh.util.json_validate``: JSON validation
