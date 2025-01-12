#!/bin/bash

# turn on bash's job control
set -m

echo "Git clone ${GITHUB_CONFIG_REPO} in ${GITHUB_CLONE_DIR}"
rm -fr /etc/named/*
git clone ${GITHUB_CONFIG_REPO} ${GITHUB_CLONE_DIR}
cp ${GITHUB_CLONE_DIR}/dns/* /etc/named

if [ ! -d /tmp/cache ]; then
    bashio::log.info "Creating cache folder"
    mkdir -p /tmp/cache
    chown named:named /tmp/cache
    chmod 755 /tmp/cache
fi

/usr/sbin/named -g -c /config/named.conf -u named &

# now we bring the primary process back into the foreground
# and leave it there
fg %1
