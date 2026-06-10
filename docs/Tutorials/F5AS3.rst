F5 AS3 Management
=================

Introduction
------------

This tutorial provides a comprehensive guide to managing F5 BIG-IP Application Services 3 (AS3) declarations using Restsh. It is designed for network and infrastructure engineers who need to programmatically manage application delivery services on F5 BIG-IP systems.

What is AS3?
------------

AS3 (Application Services 3) is an F5 BIG-IP extension that enables declarative management of application services through a REST API. Instead of manually configuring virtual servers, pools, and policies through the web interface or CLI, AS3 allows you to define your entire application infrastructure as a JSON declaration and deploy it programmatically.

Key features of AS3:

- **Declarative syntax**: Define desired state in JSON format, not imperative steps
- **REST API driven**: Full programmatic control via HTTP/REST endpoints
- **Version-controlled configurations**: Treat infrastructure as code
- **Atomic deployments**: Ensure consistent, all-or-nothing changes
- **Built-in validation**: Dry-run capability for pre-deployment verification

AS3 operates through the F5 iAppsLX framework and exposes endpoints under ``/mgmt/shared/appsvcs/`` for managing tenants and declarations.

For complete API reference and examples, see:

- `F5 BIG-IP Application Services 3 Extension Documentation <https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/>`__

Initial configuration of Restsh
-------------------------------

See :doc:`First Steps <../FirstSteps/index>` for the initial configuration of Restsh.

Connect
-------

Connect to the F5 with Restsh:

- ``restsh``
- Select your F5

1. Install or update AS3
------------------------

Before you can use AS3 to manage application services, you must install the AS3 extension package on your F5 BIG-IP system. The AS3 extension is distributed as an RPM  file through the official F5 support portal.

**Prerequisites**:

- Access to `myF5 <https://my.f5.com>`__ with valid F5 support credentials
- Administrator or sufficient privileges on the F5 BIG-IP system
- Network connectivity from your management system to the F5 BIG-IP

.. note::

   The GitHub repository for AS3 is no longer actively maintained. Always download the official RPM from myF5 to ensure you have the latest AS3 package.

**Installation steps**:

1. Download the AS3 RPM file from myF5 to your local system or upload it to the F5 system
2. Execute the installation command:

   .. code:: sh

      f5.pkg.install <rpm file>

**Verification**:

After installation, verify that AS3 is properly installed and functional:

.. code:: sh

   # List all installed iAPPsLX packages
   # This command shows all extended packages currently deployed on the system
   f5.pkg.list

   # Display AS3 package information
   # Shows version, build number, and deployment status
   f5.as3.info

Once the installation is confirmed, you can proceed to create and manage AS3 declarations.

2. Create your first Tenant
---------------------------

A tenant in AS3 represents a logical container for organizing applications and their related resources (virtual servers, pools, policies, etc.). Each tenant is a top-level entity that can be independently managed, updated, or deleted. A tenant is represented as a partition in the F5 BIG-IP configuration.

**Understanding tenants**:

- Tenants provide organizational isolation and separation of concerns
- Each tenant declaration is self-contained and can define multiple applications
- Tenant names must be unique within the AS3 deployment
- Tenants are managed through the REST-API endpoint ``/mgmt/shared/appsvcs/declare``

**Creating a declaration file**:

You need to create a JSON declaration file that contains the complete definition of your tenant and its applications. The declaration must conform to the `AS3 JSON schema <https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/refguide/schema-reference.html>`_.

.. hint::

   The schema on GitHub is no longer up-to-date. You can fetch the current schema file directly from your f5: ``f5.as3.schema > as3-schema.json``

**Example: test-tenant.json**

.. code:: json

   {
      "$schema": "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/main/schema/latest/as3-schema.json",
      "class": "AS3",
      "action": "deploy",
      "declaration": {
        "class": "ADC",
        "schemaVersion": "3.57.0",
        "label": "",
        "remark": "",
        "test-tenant": {
          "class": "Tenant",
          "app1": {
            "class": "Application",
            "vs1": {
              "class": "Service_HTTP",
              "virtualAddresses": [
                "10.0.9.10"
              ]
            }
          }
        }
      }
   }

**Declaration components**:

- **$schema**: URL to the official AS3 JSON schema for validation
- **class: AS3**: Identifies this as an AS3 declaration
- **action**: Set to "deploy" to apply the configuration
- **schemaVersion**: Specifies the AS3 schema version to use
- **test-tenant**: Your tenant name
- **app1**: Application container within the tenant
- **vs1**: Virtual server (Service_HTTP in this case)
- **virtualAddresses**: IP address(es) the virtual server listens on

**Validation and deployment**:

.. code:: sh

   # Validate JSON syntax
   # This ensures the file is valid JSON before submission
   jq "." test-tenant.json

   # Perform a dry-run validation using AS3
   # The -v flag validates without applying changes
   # This checks schema compliance, resource availability, and potential conflicts
   f5.as3.tenant.declare -v test-tenant.json

   # Deploy the declaration to the F5 system
   # This applies all changes atomically
   f5.as3.tenant.declare test-tenant.json

After deployment, AS3 translates the JSON declaration into native F5 BIG-IP configuration objects.

3. Tenant management
--------------------

Once tenants are deployed, you can perform various management operations to monitor, inspect, and manage your AS3 deployments.

**List deployed tenants**:

To see all currently deployed tenants on the F5 system:

.. code:: sh

   # List all Tenants
   # Returns a summary of all deployed tenants and their status
   f5.as3.tenant.list

This command queries the ``/mgmt/shared/appsvcs/declare`` endpoint and displays all active tenant names.

**Retrieve tenant configuration**:

To inspect the complete declaration of a specific tenant:

.. code:: sh

   # Get the declaration of a specific Tenant
   # Displays the full JSON declaration currently deployed
   f5.as3.tenant.get test-tenant

This retrieves the exact declaration that was deployed for the specified tenant, useful for verification or documentation purposes.

4. Update the tenant
--------------------

Updating existing tenants follows the same declarative model as creation. To modify a tenant's configuration, you edit the declaration file and redeploy it.

**Update workflow**:

1. Modify the declaration file (test-tenant.json) with desired changes
2. Validate the updated declaration using the dry-run option
3. Deploy the updated declaration

**Important considerations**:

- AS3 uses declarative updates: the new declaration replaces the old one completely
- Any resources not included in the updated declaration will be removed
- Updates are atomic: either the entire declaration succeeds or fails as a unit
- Always validate before deploying to production to prevent service interruptions

.. code:: sh

   # Validate the updated declaration first
   f5.as3.tenant.declare -v test-tenant.json

   # Deploy the updated declaration
   # This will atomically replace the existing tenant configuration
   f5.as3.tenant.declare test-tenant.json

5. Delete the tenant
--------------------

When you no longer need a tenant and its associated resources, you can delete it. AS3 provides a dedicated command for safe tenant removal.

**Deletion process**:

Deleting a tenant removes:

- The tenant container itself
- All applications within the tenant
- All virtual servers, pools, profiles, and policies defined in the tenant
- Any other resources explicitly created by the tenant declaration

**Important notes**:

- Tenant deletion is permanent and cannot be undone without redeployment
- Always verify you are deleting the correct tenant
- Consider backing up the tenant declaration before deletion if you may need to restore it

.. code:: sh

   # Delete the tenant and all its resources
   # This atomically removes the entire tenant and its configuration
   f5.as3.tenant.remove test-tenant

After execution, the tenant and all its resources are completely removed from the F5 system.

6. Templating
-------------

For managing multiple similar deployments or creating reusable configuration patterns, Restsh integrates the Mustache template engine. This allows you to parameterize AS3 declarations using variables that are substituted at deployment time.

For detailed templating information, see: :doc:`Templating </Advanced/Templating/index>`

**Benefits of templating**:

- **Reusability**: Define configuration patterns once, deploy to many tenants or systems
- **Maintainability**: Store common configuration logic in templates
- **Consistency**: Ensure standardized deployments across environments
- **Infrastructure as Code**: Parameterize infrastructure for different environments (dev, staging, production)
- **Reduced errors**: Eliminate manual value substitution

**Template syntax**:

Replace hardcoded values in your declaration with Mustache variables using ``{{VARIABLE_NAME}}`` syntax.

**Example template: test-tenant.tmpl**

.. code:: json

   {
      "$schema": "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/main/schema/latest/as3-schema.json",
      "class": "AS3",
      "action": "deploy",
      "declaration": {
        "class": "ADC",
        "schemaVersion": "3.57.0",
        "label": "",
        "remark": "",
        "{{TENANT_NAME}}": {
          "class": "Tenant",
          "app1": {
            "class": "Application",
            "{{VS1_NAME}}": {
              "class": "Service_HTTP",
              "virtualAddresses": [
                "{{VS1_IP}}"
              ]
            }
          }
        }
      }
   }

**Variable file: test-tenant.var**

Create a separate file containing variable assignments:

.. code:: sh

   # Define template variables
   # These values will be substituted into the template during deployment
   TENANT_NAME="test-tenant"
   VS1_NAME="vs1"
   VS1_IP="10.0.9.10"

**Deployment with templating**:

Deploy a templated declaration by specifying the template flag and variable file:

.. code:: sh

   # Deploy with template processing
   # -t flag: Enable template mode
   # -d flag: Specify the variable file to read substitutions from
   f5.as3.tenant.declare -t -d test-tenant.var test-tenant.tmpl

**Templating workflow**:

1. Create a template file (.tmpl) with Mustache variables
2. Create a variable file (.var) with substitution values
3. Deploy using the -t and -d flags to process the template
4. Restsh substitutes variables and deploys the resulting declaration
5. Repeat with different variable files for different deployments

Summary
-------

This tutorial has covered the complete lifecycle of AS3 tenant management using Restsh:

**Key takeaways**:

1. **AS3 fundamentals**: AS3 enables declarative, programmable management of F5 BIG-IP application services through REST APIs and JSON declarations.
2. **Installation**: Download and install the AS3 extension RPM from myF5, then verify installation using package management commands.
3. **Tenant creation**: Define application services in JSON declarations that conform to the AS3 schema, then deploy to create tenants on the F5 system.
4. **Validation**: Always use dry-run mode to validate declarations before production deployment to catch configuration errors early.
5. **Management operations**: Use dedicated commands to list tenants, retrieve configurations, and monitor deployments.
6. **Updates**: Modify and redeploy declarations using the same workflow as creation; updates are atomic and complete.
7. **Deletion**: Remove tenants safely using the dedicated removal command, which cleanly removes all associated resources.
8. **Templating**: Leverage Mustache templates to parameterize declarations and enable reusable configuration patterns across multiple deployments.

**Best practices**:

- Maintain version control for all declaration and template files
- Validate all declarations in a pre-production environment before deploying to production
- Use templates for multi-tenant deployments to ensure consistency
- Document variable files and their purpose for operational clarity
- Back up existing declarations before performing updates
- Use meaningful tenant and application names for clarity and maintainability

**Next steps**:

- Explore advanced AS3 features such as persistence profiles, SSL/TLS configurations, and so on
- Integrate AS3 deployments into CI/CD pipelines for automated infrastructure provisioning
- Review the official F5 AS3 documentation for comprehensive API reference and advanced use cases
- Implement Restsh templating for multi-environment deployments (development, staging, production)
