# Use Restsh with GitLab

```sh
RESTSH_MODULES=("cert" "custom" "gitlab")
```

All functions for this module are prefixed with `gitlab.`. The `aafw` module provides functions for the Axians Automation Framework and are not useful in standalone setups.

Example configuration file: `.restsh-config.dist.gitlab`

## Authentication

You can use a private token for authentication. Set `RESTSH_TOKEN_HEADER` to `PRIVATE-TOKEN` and set the `RESTSH_TOKEN_VALUE` to your generated private token.

### .restsh-config for token based authentication

``sh
[ -n "${RESTSH_AUTH+x}" ] || export RESTSH_AUTH="token"
[ -n "${RESTSH_TOKEN_HEADER+x}" ] || export RESTSH_TOKEN_HEADER="PRIVATE-TOKEN"
[ -n "${RESTSH_TOKEN_VALUE+x}" ] || export RESTSH_TOKEN_VALUE="<private token value>"
``

### Axians Automation Framework Integration

To use Axians Automation Framework specific functions you must configure below variables and enable the module `aafw` in addition to the `gitlab` module.

```sh
# Axians Automation Framework settings
# Clone with https
#[ -n "${RESTSH_AAFW_URI+x}" ] || export RESTSH_AAFW_URI="https://${RESTSH_HOST}/"
# Clone with ssh
[ -n "${RESTSH_AAFW_URI+x}" ] || export RESTSH_AAFW_URI="git@${RESTSH_HOST}:"
# Axians Automation Framework Top Group
[ -n "${RESTSH_AAFW_GROUP+x}" ] || export RESTSH_AAFW_GROUP="aafw"
# Axians Automation Framework Skeleton Projects
[ -n "${RESTSH_AAFW_AS3SKELETON+x}" ] || export RESTSH_AAFW_AS3SKELETON="${RESTSH_AAFW_GROUP}/as3skeleton"
[ -n "${RESTSH_AAFW_DOSKELETON+x}" ] || export RESTSH_AAFW_DOSKELETON="${RESTSH_AAFW_GROUP}/doskeleton"
[ -n "${RESTSH_AAFW_WAFSKELETON+x}" ] || export RESTSH_AAFW_WAFSKELETON="${RESTSH_AAFW_GROUP}/wafskeleton"
# ART
[ -n "${RESTSH_AAFW_ART+x}" ] || export RESTSH_AAFW_ART="${RESTSH_AAFW_GROUP}/art"
# Default project settings
[ -n "${RESTSH_AAFW_PROJECT_SETTINGS+x}" ] || RESTSH_AAFW_PROJECT_SETTINGS="$RESTSH_PATH/modules/aafw/templates/project_settings_default.json"
```

## References

- [GitLab API](https://docs.gitlab.com/ee/api/rest/)
