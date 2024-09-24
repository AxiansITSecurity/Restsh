# Use restsh with F5 Next

## Authentication

F5 Next supports only token based authentication.

```sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
```

restsh asks for the credentials to retrieve the token. If you want to integrate restsh in a pipeline script you can simply set the environment variables `RESTSH_USER` and `RESTSH_PASS`.

To get a token run `next.auth.login` to retrieve the access and refresh token. It uses the provided username and password to retrieve the tokens and sets the `RESTSH_TOKEN_VALUE` and `RESTSH_REFRESH_TOKEN` environment variables. The Auth token lifetime is saved in the `.RESTSH_TOKEN_LIFETIME` file in the restsh folder. The expiration of the Auth Token is checked before each script execution and refreshed on demand.

To renew the access token run `next.auth.refresh`.

## References

- [API documentation](https://clouddocs.f5.com/products/bigip-next/mgmt-api/latest/ApiReferences/bigip_public_api_ref/r_openapi-next.html)
