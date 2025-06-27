# Usage examples for F5

## Get all virtual servers

```sh
GET /mgmt/tm/ltm/virtual?\$select=fullPath
# or
f5.ltm.vs.list
```

## Get details of a virtual servers

```sh
f5.ltm.vs.get /Common/vs_test
```

## Attach a log profile to a list of virtual servers

```sh
cat > $RESTSH_TMP/log-profile.json << EOL
{
 "securityLogProfiles": [
    "/Common/siem_all_requests"
  ]
}
EOL

while read -r VS
do
    PATCH "/mgmt/tm/ltm/virtual/$VS" < $RESTSH_TMP/log-profile.json
done < VIRTUAL_SERVERS.array
```

## Change enforcement mode of an asm policy

- Policy: /Common/t

```sh
# Calculate the policy hash
HASH=$(f5.asm.policy.gethash /Common/test-policy)

# Change to blocking mode
PATCH "/mgmt/tm/asm/policies/$HASH" <<< '{"enforcementMode": "blocking" }' | JQ "[.fullPath,.enforcementMode]"

# Do not forget to apply the policy
f5.asm.policy.apply "$HASH"
```

## Apply all policies that are modified

```sh
f5.asm.policy.list -r -f ".items[] | select(.isModified == true) | .fullPath" | XARGS f5.asm.policy.apply
```

## Apply ready signatures for all policies

```sh
f5.asm.signaturestaging.enforce
```

## Export all policies as json

```sh
f5.asm.policy.list -r -f ".items[].fullPath" | XARGS f5.asm.policy.export
```

## Add disallowed filetypes

- Policy: /Common/policy

```sh
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
```

## Add disallowed urls

- Policy: /Common/policy

```sh
# Read an array into ARRAY_URLS_DISALLOWED
# One url per line
restsh.util.setvars aafw/waftemplates/config/default-policy-v16/URLS_DISALLOWED.array

# Iterate through the array and add one url at a time
for URL in "${ARRAY_URLS_DISALLOWED[@]}"
do
    f5.asm.entity.urls-disallowed.add /Common/policy "$URL"
done
```

## Modify defense attributes of an json profile

- Policy: `/Common/apisecurity`
- JSON profile: `json_POST_~trading~rest~sell_stocks.php`

```sh
f5.asm.entity.modify -t json-profiles.defense-attributes.json -sVAR_JSON_MAX_DATA_LENGTH=5 -sVAR_JSON_MAX_ARRAY_LENGTH=2 -sVAR_JSON_MAX_STRUCTURE_DEPTH=3 -sVAR_JSON_MAX_VALUE_LENGTH=10 /Common/apisecurity json-profiles json_POST_~trading~rest~sell_stocks.php
```
