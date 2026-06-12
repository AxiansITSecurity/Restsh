F5 New Declarative API
======================

Introduction
------------

This tutorial provides first insights to managing F5 BIG-IP Applications with the new declarative API using Restsh. It is designed for network and infrastructure engineers who need to programmatically manage application delivery services on F5 BIG-IP systems.

What is the new declarative API?
--------------------------------

The new declarative API is first shipped in F5 BIG-IP v21.1 as an alpha version.

.. warning:: Do not use it in production.

Read more: https://techdocs.f5.com/en-us/bigip-21-1-0/big-ip-declarative-api/big-ip-declarative-api.html

Initial configuration of Restsh
-------------------------------

See :doc:`First Steps <../FirstSteps/index>` for the initial configuration of Restsh.

Connect
-------

Connect to the F5 with Restsh:

- ``restsh``
- Select your F5

1. Create your first app
---------------------------

A application represents a logical container for organizing applications and their related resources (virtual servers, pools, policies, etc.). Each application is a top-level entity that can be independently managed, updated, or deleted.

**Understanding apps**:

- Logical grouping of BIG-IP resources into applications
- Declarative deployment workflows using BIG-IP-native resource properties

**Example template: test-app.json**

.. code:: json

   {
      "name": "test-app",
      "partition": "Common",
      "resources": [
         {
            "kind": "tm:ltm:node",
            "properties": {
              "name": "10.0.8.10",
               "address": "10.0.8.10",
               "monitor": "default"
            }
         },
         {
            "kind": "tm:ltm:node",
            "properties": {
              "name": "10.0.8.11",
               "address": "10.0.8.11",
               "monitor": "default"
            }
         }
      ]
   }

2. App management
--------------------

Once apps are deployed, you can perform various management operations to monitor, inspect, and manage your apps.

**List deployed apps**:

To see all currently deployed apps on the F5 system:

.. code:: sh

   # List all apps
   # Returns a summary of all deployed apps and their status
   f5.declared.app.list

**Retrieve app configuration**:

To inspect the complete declaration of a specific app:

.. code:: sh

   # Get the declaration of a specific app
   # Displays the full JSON declaration currently deployed
   f5.declared.app.get test-app

This retrieves the exact declaration that was deployed for the specified app, useful for verification or documentation purposes.

3. Update the app
--------------------

Updating existing apps follows the same declarative model as creation. To modify a app's configuration, you edit the declaration file and redeploy it.

**Update workflow**:

1. Modify the declaration file (test-app.json) with desired changes
2. Deploy the updated declaration

**Important considerations**:

- The new declaration replaces the old one completely
- Any resources not included in the updated declaration will be removed
- Updates are atomic: either the entire declaration succeeds or fails as a unit
- Always validate before deploying to production to prevent service interruptions

.. code:: sh

   # Deploy the updated declaration
   # This will atomically replace the existing app configuration
   f5.declared.app.declare -u test-app.json

4. Delete the app
--------------------

When you no longer need a app and its associated resources, you can delete it. The API provides a dedicated command for safe app removal.

Deleting an app removes:

- The app container (folder) itself
- All applications within the app
- All virtual servers, pools, profiles, and policies defined in the app
- Any other resources explicitly created by the app declaration

**Important notes**:

- App deletion is permanent and cannot be undone without redeployment
- Always verify you are deleting the correct app
- Consider backing up the app declaration before deletion if you may need to restore it

.. code:: sh

   # Delete the app and all its resources
   # This atomically removes the entire app and its configuration
   f5.declared.app.remove test-app

After execution, the app and all its resources are completely removed from the F5 system.

5. Templating
-------------

For managing multiple similar deployments or creating reusable configuration patterns, Restsh integrates the Mustache template engine. This allows you to parameterize app declarations using variables that are substituted at deployment time.

For detailed templating information, see: :doc:`Templating </Advanced/Templating/index>`

**Benefits of templating**:

- **Reusability**: Define configuration patterns once, deploy to many apps or systems
- **Maintainability**: Store common configuration logic in templates
- **Consistency**: Ensure standardized deployments across environments
- **Infrastructure as Code**: Parameterize infrastructure for different environments (dev, staging, production)
- **Reduced errors**: Eliminate manual value substitution

**Template syntax**:

Replace hardcoded values in your declaration with Mustache variables using ``{{VARIABLE_NAME}}`` syntax.

**Example template: test-app.tmpl**

.. code::

   {
      "name": "{{NAME}}",
      "partition": "{{PARTITION}}",
      "resources": [
         {{#NODES}}
           {{MO_COMMA_IF_NOT_FIRST}}
           {
              "kind": "tm:ltm:node",
              "properties": {
                 "name": "{{.}}",
                 "address": "{{.}}",
                 "monitor": "default"
              }
           }
         {{/NODES}}
      ]
   }

**Variable file: test-app.var**

Create a separate file containing variable assignments:

.. code:: sh

   # Define template variables
   # These values will be substituted into the template during deployment
   NAME="test"
   PARTITION="Common"
   NODES=("10.0.8.10" "10.0.8.11")

**Deployment with templating**:

Deploy a templated declaration by specifying the template flag and variable file:

.. code:: sh

   # Deploy with template processing
   # -t flag: Enable template mode
   # -d flag: Specify the variable file to read substitutions from
   f5.declared.app.declare -t -d test-app.var test-app.tmpl

**Templating workflow**:

1. Create a template file (.tmpl) with Mustache variables
2. Create a variable file (.var) with substitution values
3. Deploy using the -t and -d flags to process the template
4. Restsh substitutes variables and deploys the resulting declaration
5. Repeat with different variable files for different deployments

Summary
-------

This tutorial has covered the complete lifecycle of a new declarative app using Restsh:

**Key takeaways**:

1. **Declarative API**: The new API enables declarative, programmable management of F5 BIG-IP application services through REST APIs and JSON declarations.
2. **App creation**: Define application services in JSON declarations , then deploy to create apps on the F5 system.
3. **Validation**: Always use dry-run mode to validate declarations before production deployment to catch configuration errors early.
4. **Management operations**: Use dedicated commands to list apps, retrieve configurations, and update the app.
5. **Updates**: Modify and redeploy declarations using the same workflow as creation; updates are atomic and complete.
6. **Deletion**: Remove apps safely using the dedicated removal command, which cleanly removes all associated resources.
7. **Templating**: Leverage Mustache templates to parameterize declarations and enable reusable configuration patterns across multiple deployments.

**Best practices**:

- Maintain version control for all declaration and template files
- Validate all declarations in a pre-production environment before deploying to production
- Use templates for multi-app deployments to ensure consistency
- Document variable files and their purpose for operational clarity
- Backup existing declarations before performing updates
- Use meaningful app and application names for clarity and maintainability

**Next steps**:

- Explore advanced features such as persistence profiles, SSL/TLS configurations, and so on
- Integrate App deployments into CI/CD pipelines for automated infrastructure provisioning
- Review the official documentation for comprehensive API reference and advanced use cases
- Implement Restsh templating for multi-environment deployments (development, staging, production)

**Used Restsh commands**:

- ``f5.declared.app.declare`` - Create or update an app
- ``f5.declared.app.get`` - Get the app declaration
- ``f5.declared.app.list`` - Lists all app declarations
- ``f5.declared.app.remove`` - Removes an app declaration
- ``restsh.util.json_validate``: JSON validation
