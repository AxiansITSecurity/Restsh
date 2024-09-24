# Use restsh with GitLab

## Authentication

You can use a private token for authentication. Set `RESTSH_TOKEN_HEADER` to `PRIVATE-TOKEN` and set the `RESTSH_TOKEN_VALUE` to your generated private token.

### .restsh-config for token based authentication

```sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="PRIVATE-TOKEN"
[ -n "${RESTSH_TOKEN_VALUE+x}" ] || export RESTSH_TOKEN_VALUE="<private token value>"
```

## References

- [GitLab API](https://docs.gitlab.com/ee/api/rest/)
