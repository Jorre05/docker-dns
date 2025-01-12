FROM alpine:latest

MAINTAINER github.com/jorre05
LABEL Description="DNS (bind) Docker image."

ENV GITHUB_CONFIG_REPO=""
ENV GITHUB_CLONE_DIR=""

RUN apk --no-cache add bind bash tzdata git

COPY named.sh /tmp/named.sh
CMD ["/bin/bash", "/tmp/named.sh"]

