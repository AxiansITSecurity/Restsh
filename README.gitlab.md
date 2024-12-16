# Use restsh with GitLab

## Authentication

You can use a private token for authentication. Set `RESTSH_TOKEN_HEADER` to `PRIVATE-TOKEN` and set the `RESTSH_TOKEN_VALUE` to your generated private token.

### .restsh-config for token based authentication

```sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="PRIVATE-TOKEN"
[ -n "${RESTSH_TOKEN_VALUE+x}" ] || export RESTSH_TOKEN_VALUE="<private token value>"
```

### Axians Automation Framework Integration

To use Axians Automation Framework specific functions you must configure below variables and enable the module `aafw` in addition to the `gitlab` module.

```sh
[ -n "${RESTSH_AAFW_URI+x}" ] || export RESTSH_AAFW_URI="git@${RESTSH_HOST}:"
[ -n "${RESTSH_AAFW_GROUP+x}" ] || export RESTSH_AAFW_GROUP="ax-f5-automation-framework"
```

## References

- [GitLab API](https://docs.gitlab.com/ee/api/rest/)
