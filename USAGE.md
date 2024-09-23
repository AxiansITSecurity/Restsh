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

## Create a request with mustache and post it

```sh
. "$RESTSH_PATH/dist/mo/mo"
. "$RESTSH_PATH/lib/mo/mo.functions"
VAR1="test"
MO -- << EOL | POST /api/request
{"var1": "{{VAR1}}"}
EOL
```
