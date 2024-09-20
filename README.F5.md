# Use restsh with F5

## Authentication

You can use basic authentication with username and password for authentication, if the user is a local one, else you must use the token based authentication.

Reference: https://clouddocs.f5.com/api/icontrol-soap/Authentication_with_the_F5_REST_API.html

restsh asks for username and password. If you want to integrate restsh in a pipeline script you can simply set the environment variables `RESTSH_USER` and `RESTSH_PASS`.

### .restsh-config for basic authentication

```sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="basic"
```

### .restsh-config for token based authentication

```sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="X-F5-Auth-Token"
```

Call `f5.auth.token.get` to retrieve the token. It uses the provided username and password to retrieve the token and sets the `RESTSH_TOKEN_VALUE` environment variable.

## Device Groups

You can set RESTSH_HOST to a comma separated list of the F5 cluster members management addresses.

Call `f5.cluster.setactive` before any other command to connect to the active F5 device.

## References

- https://clouddocs.f5.com/api/icontrol-rest/
- https://cdn.f5.com/websites/devcentral.f5.com/downloads/icontrol-rest-api-user-guide-16-1-0.pdf
