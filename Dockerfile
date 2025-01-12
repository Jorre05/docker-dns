FROM --platform=$BUILDPLATFORM alpine:latest
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > /log
FROM alpine

MAINTAINER github.com/jorre05
LABEL Description="DNS (bind) Docker image."

ENV DHCP4_SERVER=true
ENV DHCP6_SERVER=false
ENV GITHUB_CONFIG_REPO=""
ENV GITHUB_CLONE_DIR=""

RUN apk --no-cache add bind bash tzdata git

COPY named.sh /etc/named/
CMD ["/bin/bash", "/etc/named/named.sh"]

