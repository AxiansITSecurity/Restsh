# restsh

restsh is a small framework to work with REST api's within the bash. It is designed to be used interactively, in scripts or in CI/CD pipelines. This framework is work-in-progress. I will add new commands on demand.

This framework includes the [mustache template engine](https://github.com/tests-always-included/mo) written in bash.

restsh is not a shell. It sets only some environment variables and defines helper functions to access and parse REST api's. You can combine the power of bash, jq and mustache to create your own REST shell.

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

### Debug

Print all executed commands and enables verbose mode of curl and mustache.

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

See [USAGE.md](USAGE.md)

## Dependencies

restsh works only inside the bash shell and needs standard linux utilities like sed, grep, etc.

Further dependencies are:

- `curl`
- `jq`: to support json payload

## Customize

You can add your own scripts into the `restsh/bin` and `restsh/lib` folders.

- [DEVELOPING.md](DEVELOPING.md)
