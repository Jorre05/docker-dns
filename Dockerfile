FROM alpine:latest

MAINTAINER github.com/jorre05
LABEL Description="DNS (bind) Docker image."

RUN apk --no-cache add bind bash tzdata git

COPY named.sh /tmp/named.sh
CMD ["/bin/bash", "/tmp/named.sh"]

