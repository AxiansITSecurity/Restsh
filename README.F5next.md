# Use restsh with F5 next

API documentation: https://clouddocs.f5.com/products/big-iq/mgmt-api/v0.0.1/ApiReferences/bigip_public_api_ref/r_openapi-next.html

# Authentication

You must use token based authentication.

**.restsh-config for token based authentication**

```sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
```

In both cases restsh asks for username and password. If you want to integrate restsh in a pipeline script you can simply set the environment variables `RESTSH_USER` and `RESTSH_PASS`.

To get a token run `next.auth.login` to retrieve the access and refresh token. It uses the provided username and password to retrieve the tokens and sets the `RESTSH_TOKEN_VALUE` and `RESTSH_REFRESH_TOKEN` environment variables.

To renew the access token run `next.auth.refresh`.
