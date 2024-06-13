FROM alpine:latest
RUN apk add --no-cache bash coreutils git jq yq sed grep curl nfs-utils findutils procps util-linux libxml2-utils perl-xml-xpath openssh-client-default openssl
