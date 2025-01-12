#!/bin/bash

# turn on bash's job control
set -m

if [ ! -d /data/cache ]; then
    bashio::log.info "Creating cache folder"
    mkdir -p /tmp/cache
    chown named:named /tmp/cache
    chmod 755 /tmp/cache
fi

/usr/sbin/named -g -c /config/named.conf -u named &

# now we bring the primary process back into the foreground
# and leave it there
fg %1
