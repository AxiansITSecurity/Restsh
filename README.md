# Use restsh

restsh is a small framework to work with REST-API's within the bash. It is designed to be used interactively, in scripts or in CI/CD pipelines.

This framework includes the [mustache template engine](https://github.com/tests-always-included/mo) written in bash.

restsh is not a shell. It sets only some environment variables and defines helper functions to access and parse REST api's. You can combine the power of bash, jq and mustache to interact with REST-API's.

## Running interactively

```sh
git clone <clone uri>
cd restsh
#
# Rename .restsh-config.dist to .restsh-config and customize it or export some environment variables.
#
# export RESTSH_HOST="localhost"
#
# Basic authentication
# export RESTSH_AUTH="basic"
# export RESTSH_USER="apiuser"
# export RESTSH_PASS="apipass"
# If no username or password is set, restsh asks for it on start.
#
# Token based authentication
# export RESTSH_AUTH="token"
# export RESTSH_TOKEN_HEADER="X-Auth-Token"
# export RESTSH_TOKEN_VALUE="the_token"
#
# You can also use the .netrc file to store the credentials.
# export RESTSH_AUTH="netrc"
#
restsh/restsh.start
```

### Custom config

You can use custom config files to work with several api endpoints. If not defined restsh searches for a file named `.restsh-config` in the current folder and in the user home.

```sh
restsh/restsh.start custom-config1
```

### Password encryption

You can store the RESTSH_PASS AES256 encrypted in the configuration file.

- Start restsh
- Create the encrypted password string:

    ```sh
    restsh.util.encrypt
    ```

- Exit restsh and define the RESTSH_PASS variable as `<output of above command>`, beginning with AES256:.
- In interactive mode, restsh asks for the secret if it is not defined in RESTSH_SECRET. In script mode it terminates with an error.

### Debug

Print all executed commands and enables verbose mode of curl.

```sh
export RESTSH_DEBUG=1
restsh/restsh.start
```

## Include it in a script

Simply export the RESTSH_PATH and source the `restsh.init` file.

```sh
export RESTSH_PATH="/path/to/restsh"
#export RESTSH_CONFIG="custom-config"
. "$RESTSH_PATH/restsh.init"
```

## Usage

- [Examples](EXAMPLES.md)
- [Examples for F5](EXAMPLES.F5.md)

### Available modules

| Prefix | Description |
| ------ | ----------- |
| aafw | Axians Automation Framework |
| cert | Certificate handling |
| f5 | F5 BIG-IP Classic |
| gitlab | GitLab |
| next | F5 BIG-IP Next |
| scm | Sectigo Cert Manager |

Enable modules:

```sh
RESTSH_MODULES=("aafw" "cert" "custom" "f5" "gitlab" "next" "scm")
```

## Dependencies

restsh works only inside the bash shell and requires standard GNU core utilities like awk, sed, grep, etc.

Further dependencies are:

- curl (v7.76.0)
- jq

## Customize

You can add your own scripts into the `restsh/bin/custom` and `restsh/lib/custom` folders.

- [DEVELOPING.md](DEVELOPING.md)
