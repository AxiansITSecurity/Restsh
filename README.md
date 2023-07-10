# restsh

restsh is a small framework to work with rest api's within the bash. It is designed to be used interactively, in scripts or in CI/CD pipelines. This framework is work-in-progress. I will add new commands on demand.

This framework includes the [mustache template engine](https://github.com/tests-always-included/mo) written in bash.

## Running interactively

```sh
git clone https://github.com/JuergenMang/restsh.git
cd restsh
# Rename .restsh-config.dist to .restsh-config and customize it or export some environment variables
# export RESTSH_HOST="10.125.245.51"
# Basic authentication
# export RESTSH_USER="basic"
# export RESTSH_USER="apiuser"
# export RESTSH_PASS="apipass"
# Bearer authentication
# export RESTSH_AUTH="bearer"
# export RESTSH_BEARER="thetoken"
# You can also use the .netrc file to store the credentials
# export RESTSH_NETRC=1
restsh/restsh.start
```

### Custom config

You can use custom config files to work with several api endpoints. If not defined restsh searches for a file named `.restsh-config` in the current folder and in the user home.

```sh
restsh/restsh.start custom-config1
```

### Help

List all custom environment variables and commands.

```sh
restsh.help
```

### Debug

Print all executed commands and enables verbose mode of curl.

```sh
export DEBUG=1
restsh/restsh.start
```

## Using in a script

Simply export the RESTSH_PATH and source the `restsh.init` file.

```sh
export RESTSH_PATH="/path/to/restsh"
#export RESTSH_CONFIG="custom-config"
. "$RESTSH_PATH/restsh.init"
```

## Dependencies

Restsh works only under the bash shell and needs standard linux utilities like sed, grep, etc.

Further dependencies are:

- curl
- jq: to support json payload
- yq: to support xml payload

## Customize

You can add your own scripts into the `restsh/bin` directory. Please consider to create a pull request.

- [DEVELOPING.md](DEVELOPING.md)

## Usage

```sh
# Simple GET request
GET /api/version

# Create a request with mustache and post it
VAR1="test"
mo << EOL | POST /api/request
> {"var1": "{{VAR1}}"}
> EOL
```

## Custom mustache functions

You can find some custom mustache functions in the `mo/lib` folder.

## License

GPLv3 or newer, see LICENSE.md for the full license text.

## Copyright

(c) 2023 Juergen Mang <juergen.mang@axians.de>
