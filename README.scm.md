# Use restsh with Sectigo Cert Manager

## Authentication

SCM uses OAuth2 based authentication. You must create a client id and client secret in SCM.

### .restsh-config for token based authentication

```sh
[ -n "${RESTSH_HOST+x}" ] || export RESTSH_HOST="admin.enterprise.sectigo.com"
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="Authorization"
[ -n "${SCM_CLIENTID+x}" ] || export SCM_CLIENTID=""
[ -n "${SCM_SECRET+x}" ] || export SCM_SECRET=""
```

Type `scm.auth.login` to retrieve a bearer token.
