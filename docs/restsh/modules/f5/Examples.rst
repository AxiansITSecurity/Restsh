Examples
========

Common F5 examples for managing LTM and ASM objects through RESTSH.

LTM
---

Functions for managing LTM objects such as virtual servers, pools, and nodes.

List all virtual servers
~~~~~~~~~~~~~~~~~~~~~~~~

List all virtual servers using the native GET function with a query parameter to select only the fullPath attribute.

.. code:: sh

   GET /mgmt/tm/ltm/virtual?\$select=fullPath

You can also use the F5 module command to list all virtual servers.

.. code:: sh

   f5.ltm.vs.list

   # Or with the -r option to see the raw HTTP response
   f5.ltm.vs.list -r

Get details of a virtual server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Retrieve the configuration of a specific virtual server.

.. code:: sh

   f5.ltm.vs.get /Common/vs_test

Attach a log profile to a list of virtual servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apply a security log profile to all virtual servers listed in a file. The file should contain one virtual server name per line.

.. code:: sh

   # Create a temporary JSON file with the log profile configuration
   cat > $RESTSH_TMP/log-profile.json <<EOL
   {
       "securityLogProfiles": [
           "/Common/siem_all_requests"
       ]
   }
   EOL

   # Define an array of virtual servers to which the log profile will be attached
   ARRAY_VIRTUAL_SERVERS=("/Common/vs1" "/Common/vs2" "/Common/vs3")

   # You can alternatively read the virtual server names from a file.
   # Each line in the file should contain one virtual server name.
   restsh.util.setvar $RESTSH_TMP/VIRTUAL_SERVERS.array
   
   for VS in "${ARRAY_VIRTUAL_SERVERS[@]}"
   do
       PATCH "/mgmt/tm/ltm/virtual/${VS//\//\~}" < $RESTSH_TMP/log-profile.json
   done

ASM
---

Functions for manaaging ASM policies and entities.

Change enforcement mode of an ASM policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Switch an ASM policy from transparent to blocking enforcement.

- Policy: /Common/test-policy

.. code:: sh

   # Calculate the policy hash
   HASH=$(f5.asm.policy.gethash /Common/test-policy)

   # Change to blocking mode
   PATCH "/mgmt/tm/asm/policies/$HASH" <<< '{"enforcementMode": "blocking" }' | JQ "[.fullPath,.enforcementMode]"

   # Do not forget to apply the policy
   f5.asm.policy.apply "$HASH"

Apply all policies that are modified
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apply every ASM policy that currently has pending modifications.

.. code:: sh

   f5.asm.policy.list -r -f ".items[] | select(.isModified == true) | .fullPath" | XARGS f5.asm.policy.apply

Apply ready signatures for all policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Enforce staged signature updates across all ASM policies.

.. code:: sh

   f5.asm.signaturestaging.enforce

Export all policies as json
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Export each ASM policy configuration as JSON.

.. code:: sh

   f5.asm.policy.list -r -f ".items[].fullPath" | XARGS f5.asm.policy.export

Add disallowed filetypes
~~~~~~~~~~~~~~~~~~~~~~~~

Add custom disallowed file extensions to an ASM policy.

- Policy: /Common/policy

.. code:: sh

   # Read an array into ARRAY_FILETYPES_DISALLOWED
   # One filetype per line
   restsh.util.setvars aafw/waftemplates/config/default-policy-v16/FILETYPES_DISALLOWED.array

   # Iterate through the array and add one filetype at a time
   for FILETYPE in "${ARRAY_FILETYPES_DISALLOWED[@]}"
   do
       f5.asm.entity.filetypes-disallowed.add /Common/policy "$FILETYPE"
   done

   # Do not forget to apply the policy
   f5.asm.policy.apply /Common/policy

Add disallowed urls
~~~~~~~~~~~~~~~~~~~

Add custom disallowed URLs to an ASM policy.

- Policy: /Common/policy

.. code:: sh

   # Read an array into ARRAY_URLS_DISALLOWED
   # One url per line
   restsh.util.setvars aafw/waftemplates/config/default-policy-v16/URLS_DISALLOWED.array

   # Iterate through the array and add one url at a time
   for URL in "${ARRAY_URLS_DISALLOWED[@]}"
   do
       f5.asm.entity.urls-disallowed.add /Common/policy "$URL"
   done

Modify defense attributes of an json profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Adjust defense settings for a JSON profile in an ASM policy.

- Policy: ``/Common/apisecurity``
- JSON profile: ``json_POST_~trading~rest~sell_stocks.php``

.. code:: sh

   f5.asm.entity.modify -t json-profiles.defense-attributes.json -sVAR_JSON_MAX_DATA_LENGTH=5 -sVAR_JSON_MAX_ARRAY_LENGTH=2 -sVAR_JSON_MAX_STRUCTURE_DEPTH=3 -sVAR_JSON_MAX_VALUE_LENGTH=10 /Common/apisecurity json-profiles json_POST_~trading~rest~sell_stocks.php
