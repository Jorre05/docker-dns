#!/bin/bash

# turn on bash's job control
set -m

mkdir /config
echo "Git clone ${GITHUB_CONFIG_REPO} in ${GITHUB_CLONE_DIR}"
git clone ${GITHUB_CONFIG_REPO} ${GITHUB_CLONE_DIR}

echo "kopie naar config"
cp -frp ${GITHUB_CLONE_DIR}/dns/* /config

chown -R named:named /config
chmod -R 755 /config

if [ ! -d /tmp/cache ]; then
    echo "Creating cache folder"
    mkdir -p /tmp/cache
    chown named:named /tmp/cache
    chmod 755 /tmp/cache
fi

/usr/sbin/named -g -c /config/named.conf -u named &

# now we bring the primary process back into the foreground
# and leave it there
fg %1
