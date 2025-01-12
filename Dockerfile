FROM alpine:latest

MAINTAINER github.com/jorre05
LABEL Description="kea-dhcp Docker image."

ENV DHCP4_SERVER=true
ENV DHCP6_SERVER=false
ENV GITHUB_REPO=

RUN apk --no-cache add bind bash tzdata git

COPY named.sh /etc/named/
COPY git.sh /etc/named/

CMD ["/bin/bash", "/etc/named/git.sh"]
CMD ["/bin/bash", "/etc/named/named.sh"]
