# Usage examples

## Show help

```sh
restsh.help

# F5 specific
restsh.help f5
```

## Simple GET request

```sh
GET /api/version
```

## Create a request with mustache and post it.

```sh
. "$RESTSH_PATH/dist/mo/mo"
. "$RESTSH_PATH/lib/mo/functions"
VAR1="test"
MO -- << EOL | POST /api/request
> {"var1": "{{VAR1}}"}
> EOL
```

## Change enforcement mode of an asm policy

- Policy: /Common/t

```sh
# Calculate the policy hash
HASH=$(f5.asm.policy.gethash /Common/t)

# Change to blocking mode
PATCH "/mgmt/tm/asm/policies/$HASH" <<< '{"enforcementMode": "blocking" }' | JQ "[.fullPath,.enforcementMode]"

# Do not forget to apply the policy
f5.asm.policy.apply "$HASH"
```

## Add disallowed filetypes to asm policy

- Policy: /Common/t
- MO Template: restsh/templates/f5/asm/entity.filetypes.json
- MO Variables: restsh/templates/f5/asm/entity.filetypes.var
- ASM entity: filetypes

```sh
# Read an array into VAR_DISALLOWED_FILETYPES
# One filetype per line
restsh.util.setvar ../declarative-waf-demo/awaftemplate/config-default/DISALLOWED_FILETYPES.array

# Iterate through the array and post one filetype at a time
for FILETYPE in ${VAR_DISALLOWED_FILETYPES[*]}
do
    VAR_DISALLOWED_FILETYPE=$FILETYPE f5.asm.entity.add /Common/t restsh/templates/f5/asm/entity.filetypes.json restsh/templates/f5/asm/entity.filetypes.var filetypes
done

# Do not forget to apply the policy
f5.asm.policy.apply /Common/t
```
