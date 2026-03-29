# Use Restsh

Restsh is a shell environment to work with REST-API's on the command line. It is designed to be used interactively, in scripts or in CI/CD pipelines.

This framework includes [MO](https://github.com/tests-always-included/mo), a mustache template engine written in bash.

Restsh is not a standalone shell. It sets only some environment variables and defines helper functions to access and parse REST-API's. You can combine the power of bash, curl, jq and mustache to interact with REST-API's.

Restsh is one of the core components of the [Axians Automation Framework](https://www.axians.de/app/uploads/sites/72/2025/10/Axians-Automation-Framework_web.pdf), which enables the automation of F5 environments using GitLab pipelines.

## Available modules

| Prefix | Description |
| ------ | ----------- |
| aafw | Axians Automation Framework specific modules. |
| cert | Simpel local Certificate handling. |
| f5 | F5 BIG-IP TMOS |
| f5osa | F5OS-A / rSeries |
| gitlab | GitLab |
| scm | Sectigo Cert Manager |

## Quickstart

- [Quickstart](https://axiansitsecurity.github.io/Restsh/Quickstart/index.html)

## Running interactively

```sh
git clone https://github.com/AxiansITSecurity/Restsh.git restsh
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
restsh/restsh.start
```

### Pre-defined config files

| Prefix | Description |
| ------ | ----------- |
| `.restsh-config.dist.f5` | F5 BIG-IP TMOS |
| `.restsh-config.dist.f5osa` | F5OS-A / rSeries |
| `.restsh-config.dist.gitlab` | GitLab |
| `.restsh-config.dist.scm` | Sectigo Cert Manager |

### Custom config

You can use custom config files to work with several api endpoints. If not defined on the command line, Restsh searches for a file named `.restsh-config` in the current folder and in the user home. If no configuration file is found a ncurses menu appears.

```sh
restsh/restsh.start custom-config1
```

Set the `RESTSH_CONFIG_PATH` environment variable to define the folder for configuration files. Subfolders are supported.

### Custom environment variables

You can use the environment variable `RESTSH_CUSTOM_ENV` to define a custom file that will be sourced from `restsh.init`.

### Certificate checking

Restsh enables uses curl to communicate with the REST-APIs. Certificate checking is enabled in all default configurations. If you encounter certificate related errors you should add the signing certificate to your system trust store. Disabling certificate checking is NOT recommended, but you can set ``RESTSH_CURL_INSECURE=1`` in the configuration file to disable it.

### Password encryption

You can store the `RESTSH_PASS` and `RESTSH_TOKEN_VALUE` AES256 encrypted in the configuration file.

- Start Restsh
- Create the encrypted password string:

    ```sh
    restsh.util.encrypt
    ```

- Exit Restsh and define the `RESTSH_PASS` variable as `<output of above command>`, beginning with `AES256:`.
- In interactive mode, Restsh asks for the secret if it is not defined in `RESTSH_SECRET`. In script mode it terminates with an error.
- As an alternative you can set `RESTSH_SECRET_FILE` to a file to read the `RESTSH_SECRET` from.

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

### Enable modules

Modules are enabled in the configuration file.

```sh
RESTSH_MODULES=("aafw" "cert" "custom" "f5" "f5osa" "gitlab" "scm")
```

## Dependencies

Restsh works only inside the bash shell and requires standard GNU core utilities like awk, sed, grep, etc.

Further dependencies are:

- curl >= v7.76.0
- jq >= 1.7
- openssl
- whiptail (newt)

## Atuin

Restsh supports the integration of [Atuin](https://atuin.sh/) for better shell history support.

```sh
# Install latest Atuin version from repository
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Import shell history"
atuin import auto
```

## Customize

You can add your own scripts into the `restsh/bin/custom` and `restsh/lib/custom` folders.

- [DEVELOPING.md](DEVELOPING.md)

## Documentation

You can build the documentation local with the `doc.sh` script or you can read it [online](https://axiansitsecurity.github.io/Restsh/).

## License

Restsh is published under the [GPLv3+ license](LICENSE.md) in the hope that others will find it useful and make use of it.
