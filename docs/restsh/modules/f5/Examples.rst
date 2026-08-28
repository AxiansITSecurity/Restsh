Examples
========

Common examples for managing F5 LTM and ASM objects with Restsh.

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

Iterate through all virtual servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can use the ``f5.ltm.vs.list`` command with a simple ``jq`` filter to iterate through all virtual servers. This is useful if you want change one setting on all your virtual servers.

.. code:: sh

   # Disable all virtual servers
   while read -r VS
   do
      PATCH "/mgmt/tm/ltm/virtual/${VS//\//\~}" <<< '{"disabled": true}'
   done < <(f5.ltm.vs.list -r | JQ -r '.items[].fullPath')

   # To re-enable all virtual servers again
   while read -r VS
   do
      PATCH "/mgmt/tm/ltm/virtual/${VS//\//\~}" <<< '{"enabled": true}'
   done < <(f5.ltm.vs.list -r | JQ -r '.items[].fullPath')


Attach a log profile to a list of virtual servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apply a security log profile to a list of virtual servers.

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

Create a snat pool
~~~~~~~~~~~~~~~~~~

Create a SNAT pool with a larger list of SNAT addresses.

.. code:: sh

   # Create an array of SNAT addresses to be added to the SNAT pool
   mapfile -t IPS < <(for F in {10..80}; do echo "10.10.10.${F}"; done)

   # Create a Mustache template for the SNAT pool definition
   cat > $RESTSH_TMP/snat-pool.json <<EOL
   {
       "name": "snat_pool_test",
       "members": [
           {{#IPS}}
               {{MO_COMMA_IF_NOT_FIRST}}
               "{{.}}"
           {{/IPS}}
       ]
   }
   EOL

   # Create the SNAT pool using the Mustache template and the array of SNAT addresses
   MO "$RESTSH_TMP/snat-pool.json" | POST /mgmt/tm/ltm/snatpool

   # Iterate through the members and set the idle timeout
   while read -r MEMBER
   do
      PATCH "/mgmt/tm/ltm/snat-translation/${MEMBER//\//\~}" <<< '{"ipIdleTimeout": 60, "tcpIdleTimeout": 60, "udpIdleTimeout": 60}'
   done < <(GET -r -f '.members[]' /mgmt/tm/ltm/snatpool/snat_pool_test)

   # Cleanup
   rm "$RESTSH_TMP/snat-pool.json"

   # Delete the snat pool
   DELETE /mgmt/tm/ltm/snatpool/snat_pool_test

iRules
~~~~~~

List all iRules.

.. code:: sh

   f5.ltm.irule.list

Download an iRule.

.. code:: sh

   f5.ltm.irule.download /Common/test test.irule

Update an iRule.

.. code:: sh

   f5.ltm.irule.update /Common/test test.irule

Batch processing iRules
^^^^^^^^^^^^^^^^^^^^^^^

Download all iRules from your F5 to current folder. This function ignores system iRules.

.. code:: sh

   f5.ltm.irule.batch download ./

Upload all iRules from current folder. This functions iterates through all files with the extension ``.irule`` and creates or updates the iRule. The iRule name on the F5 is the basename of the file.

.. code:: sh

   f5.ltm.irule.batch create ./

ASM
---

Functions for managing ASM policies and entities.

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
