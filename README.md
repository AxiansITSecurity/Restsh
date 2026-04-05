# Use Restsh

Restsh is a shell environment to work with REST-API's on the command line. It is designed to be used interactively, in scripts or in CI/CD pipelines.

This framework includes [MO](https://github.com/tests-always-included/mo), a mustache template engine written in bash.

Restsh is not a standalone shell. It transforms the Bash shell into a powerful commandline to access REST-API's and parse the responses. You can combine the power of bash, curl, jq and mustache to interact with REST-API's.

## Available modules

| Prefix | Description |
| ------ | ----------- |
| aafw | Axians Automation Framework specific modules. |
| cert | Simpel local Certificate handling. |
| f5 | F5 BIG-IP TMOS |
| f5osa | F5OS-A / rSeries |
| gitlab | GitLab |
| scm | Sectigo Cert Manager |

## Documentation

You can build the documentation locally with the `doc.sh` script or you can read it [online](https://axiansitsecurity.github.io/Restsh/).

## License

Restsh is published under the [GPLv3+ license](LICENSE.md) in the hope that others will find it useful and make use of it.
