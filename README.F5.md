# Use restsh with F5

## Authentication

You can use basic authentication with username and password for authentication, if the user is a local one, else you must use the token based authentication.

Reference: https://clouddocs.f5.com/api/icontrol-soap/Authentication_with_the_F5_REST_API.html

**.restsh-config for basic authentication**

```sh
[ -z "${RESTSH_AUTH+x}" ] && export RESTSH_AUTH="basic"
```

**.restsh-config for token based authentication**

```sh
[ -z "${RESTSH_AUTH+x}" ] && export RESTSH_AUTH="token"
[ -z "${RESTSH_TOKEN_HEADER+x}" ] && export RESTSH_TOKEN_HEADER="X-F5-Auth-Token"
```

In both cases restsh asks for username and password. If you want to integrate restsh in a pipeline script you can simply set the environment variables `RESTSH_USER` and `RESTSH_PASS`.

For token based authentication call `f5.auth.token.get` to retrieve the token. It uses the provided username and password to retrieve the token and sets the `RESTSH_TOKEN_VALUE` environment variable.

## References

- https://clouddocs.f5.com/api/icontrol-rest/
- https://cdn.f5.com/websites/devcentral.f5.com/downloads/icontrol-rest-api-user-guide-16-1-0.pdf
