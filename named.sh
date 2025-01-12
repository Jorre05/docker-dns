#!/bin/bash

# turn on bash's job control
set -m

echo "Git clone ${GITHUB_CONFIG_REPO} in ${GITHUB_CLONE_DIR}"
rm -fr /etc/named/*
git clone ${GITHUB_CONFIG_REPO} ${GITHUB_CLONE_DIR}
ls -l ${GITHUB_CLONE_DIR}
ls -l ${GITHUB_CLONE_DIR}/dns/*
cp -frp ${GITHUB_CLONE_DIR}/dns/* /etc/named/
ls -l /etc/named
chown -R named:named /etc/named
chmod -R 755 /etc/named

if [ ! -d /tmp/cache ]; then
    echo "Creating cache folder"
    mkdir -p /tmp/cache
    chown named:named /tmp/cache
    chmod 755 /tmp/cache
fi

/usr/sbin/named -g -c /etc/named/named.conf -u named &

# now we bring the primary process back into the foreground
# and leave it there
fg %1
