# Use restsh with Sectigo Cert Manager

## Authentication

SCM uses OAuth2 based authentication. You must create a client id and client secret in SCM.

```sh
[ -n "${RESTSH_HOST+x}" ] || export RESTSH_HOST="admin.enterprise.sectigo.com"
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
[ -n "${SCM_CLIENTID+x}" ] || export SCM_CLIENTID=""
[ -n "${SCM_SECRET+x}" ] || export SCM_SECRET=""
```

Type `scm.auth.login` to retrieve a bearer token.

## Client Secret encryption

You can store the SCM_SECRET AES256 encrypted in the configuration file.

To generate the encrypted string:

- Start restsh
- Create the encrypted SCM_SECRET string:

    ```sh
    restsh.util.encrypt
    ```

- Exit restsh and define the SCM_SECRET variable as `<output of above command>`, beginning with AES256:.
- In interactive mode, restsh asks for the secret if it is not defined in RESTSH_SECRET. In script mode it terminates with an error.

## References

- [Sectigo Cert Manager API](https://www.sectigo.com/knowledge-base/detail/Sectigo-Certificate-Manager-SCM-REST-API/kA01N000000XDkE)
