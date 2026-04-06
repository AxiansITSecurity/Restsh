# Restsh

Restsh is a shell environment to work with REST-API's on the command line. It is designed to be used interactively, in scripts or in CI/CD pipelines.

Restsh does not replace your shell. It transforms the Bash shell into a powerful commandline to access REST-API's and parse the responses. You can combine the power of bash, curl, jq and mustache to interact with REST-API's.

Restsh provides fast, direct, scriptable REST API operations without overhead. With Restsh, tasks that would otherwise require writing a Terraform module or an Ansible role can often be completed in minutes and just a few lines of script.

It offers hundreds of API wrapper scripts to simplify the use of REST APIs. If no script is available, the API can be accessed directly using GET, DELETE, PATCH, POST, etc. It is also easy to write your own API wrapper scripts.

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

## Support

This is the OpenSource and community supported version of Restsh. You can book enterprise-grade support from Axians IT Security GmbH. Simply write an email to <juergen.mang@sec.axians.de> to get in contact.
