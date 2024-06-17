FROM debian:stable-slim
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y --no-install-recommends openssh-client curl yq jq git libxml-xpath-perl libxml2-utils
