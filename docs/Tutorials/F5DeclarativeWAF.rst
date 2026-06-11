F5 Declarative WAF
==================

Introduction
------------

This tutorial provides a comprehensive guide to managing F5 BIG-IP WAF Declarations (ASM Policies) using Restsh. It is designed for network and infrastructure engineers who need to programmatically manage web application firewall policies on F5 BIG-IP systems.

What is Declarative WAF?
------------------------

Key features of Declarative WAF:

- **Declarative syntax**: Define desired state in JSON format, not imperative steps
- **REST API driven**: Full programmatic control via HTTP/REST endpoints
- **Version-controlled configurations**: Treat WAF policies as code
- **Atomic deployments**: Ensure consistent, all-or-nothing changes

For complete API reference and examples, see:

- `F5 Declarative WAF Documentation <https://clouddocs.f5.com/products/waf-declarative-policy/v17_1.html>`__

Initial configuration of Restsh
-------------------------------

See :doc:`First Steps <../FirstSteps/index>` for the initial configuration of Restsh.

Connect
-------

Connect to the F5 with Restsh:

- ``restsh``
- Select your F5

1. Create a blank template
--------------------------

Like any other policy, a declarative policy is also based on a template. It is best to have as few options enabled as possible and as few entries in the policy as possible. The declarative policy should only need to enable options or add entities. Therefore we create a custom ASM Policy Template based on the Blank template.

**First export the Blank template**

.. code:: sh

   f5.asm.template.export POLICY_TEMPLATE_BLANK my-blank-template.xml

**Customize Template**

The template is a XML file, edit it with your preferred editor that has XML formatting support.

- Change the name
- Remove all entities that are not absolutely necessary
- Disable all blocking options

You will enable the blocking options and add entities in your Declarative Policy.

**Re-import the template**

.. code:: sh

   f5.asm.template.import my-blank-template.xml my-blank-template

   # List all user-defined templates
   f5.asm.template.list -u

2. Create your first declarative policy
---------------------------------------

**Example: test-policy.json**

.. code:: json

   {
      "policy" : {
         "type" : "security",
         "name" : "test-policy",
         "description" : "Created by Restsh",
         "template" : {
            "name" : "my-blank-template"
         },
         "enforcementMode" : "blocking",
         "blocking-settings" : {
            "http-protocols" : [
               {
                  "description" : "No Host header in HTTP/1.1 request",
                  "enabled" : true,
                  "learn" : false
               }
            ]
         }
      }
   }

**Declaration components**:

- **type: security**: Identifies this as a security policy and not a parent policy.
- **name: test-policy**: The name of the policy.
- **template**: The name of the ASM policy template created in step 1.
- **enforcementMode: blocking:** The policy is in blocking mode

**Validation and deployment**:

.. code:: sh

   # Validate JSON syntax
   # This ensures the file is valid JSON before submission
   restsh.util.json_validate < test-policy.json

   # Deploy the policy to the F5 system
   # The policy will be applied after import
   f5.asm.policy.import test-policy.json /Common/test-policy

3. Policy management
--------------------

Once policies are deployed, you can perform various management operations to monitor, inspect, and manage your ASM policies.

**List all policies**:

To see all currently deployed policies on the F5 system:

.. code:: sh

   # List all Policies
   # Returns a summary of all deployed policies and their status
   f5.asm.policy.list

**Export a policy**:

To inspect the complete declaration of the policy:

.. code:: sh

   # Exports the declaration of a specific policy
   f5.asm.policy.export /Common/test-policy

This retrieves the exact declaration that was deployed, useful for verification or documentation purposes.

**Enforce Attack Signatures**:

If you have enabled "Signature Staging", all signatures are in staging after policy creation.

.. code:: sh

   # Enforce all signatures
   f5.asm.signaturestaging.enforce -a /Common/test-policy

   # Apply the policy
   f5.asm.policy.apply /Common/test-policy

**Delete a policy**:

.. code:: sh

   f5.asm.policy.delete /Common/test-policy

4. Templating
-------------

For managing multiple similar policies or creating reusable configuration patterns, Restsh integrates the Mustache template engine. This allows you to parameterize policy declarations using variables that are substituted at deployment time.

For detailed templating information, see: :doc:`Templating </Advanced/Templating/index>`

**Benefits of templating**:

- **Reusability**: Define configuration patterns once, deploy to many systems
- **Maintainability**: Store common configuration logic in templates
- **Consistency**: Ensure standardized deployments across environments
- **Infrastructure as Code**: Parameterize infrastructure for different environments (dev, staging, production)
- **Reduced errors**: Eliminate manual value substitution

**Template syntax**:

Replace hardcoded values in your declaration with Mustache variables using ``{{VARIABLE_NAME}}`` syntax.

**Example template: test-policy.tmpl**

.. code:: json

   {
      "policy" : {
         "type" : "security",
         "name" : "{{NAME}}",
         "description" : "Created by Restsh",
         "template" : {
            "name" : "my-blank-template"
         },
         "enforcementMode" : "{{ENFORCEMENT_MODE}}"
      }
   }

**Variable file: test-policy.var**

Create a separate file containing variable assignments:

.. code:: sh

   # Define template variables
   # These values will be substituted into the template during deployment
   NAME="test-tenant"
   ENFORCEMENT_MODE="transparent"

**Create and deploy**:

Create the policy from the template with the help of the integrated Mustache templating engine.

.. code:: sh

   # Process the template with Mustache
   MO -s=test-policy.var test-policy.tmpl > test-policy.json

   # Validate the JSON
   restsh.util.json_validate < test-policy.json

   # Deploy the policy to the F5 system
   # The policy will be applied after import
   f5.asm.policy.import test-policy.json /Common/test-policy

**Templating workflow**:

1. Create a template file (.tmpl) with Mustache variables
2. Create a variable file (.var) with substitution values
3. Create the policy from the template
4. Deploy the policy
5. Repeat with different variable files for different deployments

Summary
-------

This tutorial has covered the complete lifecycle of Declarative WAF management using Restsh:

**Key takeaways**:

1. **Declarative WAF fundamentals**: Enables declarative, programmable management of F5 ASM policies through REST APIs and JSON declarations.
2. **Management operations**: Use dedicated commands to list, retrieve configurations, and monitor deployments.
3. **Updates**: Modify and redeploy declarations using the same workflow as creation; updates are atomic and complete.
4. **Templating**: Leverage Mustache templates to parameterize declarations and enable reusable configuration patterns across multiple deployments.

**Best practices**:

- Maintain version control for all declaration and template files
- Validate all declarations in a pre-production environment before deploying to production
- Use templates for multi-tenant deployments to ensure consistency
- Document variable files and their purpose for operational clarity
- Back up existing declarations before performing updates

**Next steps**:

- Explore advanced WAF features such as OpenAPI file import
- Integrate WAF deployments into CI/CD pipelines for automated infrastructure provisioning
- Review the official F5 Declarative WAF documentation for comprehensive API reference and advanced use cases
- Implement Restsh templating for multi-environment deployments (development, staging, production)

**Used Restsh commands**:

- ``f5.asm.policy.apply``: Applies an ASM policy
- ``f5.asm.policy.delete``: Deletes an ASM policy
- ``f5.asm.policy.export``: Exports an ASM policy
- ``f5.asm.policy.import``: Imports an ASM policy
- ``f5.asm.policy.list``: Lists all ASM policies
- ``f5.asm.signaturestaging.enforce``: Enforces attack signatures
- ``f5.asm.template.export``: Exports an ASM policy template
- ``f5.asm.template.import``: Imports an ASM policy template
- ``f5.asm.template.list``: Lists all ASM policy templates
- ``restsh.util.json_validate``: JSON validation
