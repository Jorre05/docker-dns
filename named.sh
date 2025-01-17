#!/bin/bash

# turn on bash's job control
set -m

if [ -d /${GITHUB_CLONE_DIR} ]; then
    echo "Verwijderen "${GITHUB_CLONE_DIR}
    rm -fr ${GITHUB_CLONE_DIR}
fi

echo "Aanmaken git map "${GITHUB_CLONE_DIR}
mkdir -p /${GITHUB_CLONE_DIR}
git clone ${GITHUB_CONFIG_REPO} ${GITHUB_CLONE_DIR}
    
if [ ! -d /config ]; then
    echo "Aanmaken config map "
    mkdir -p /config
    chown named:named /config
    chmod 755 /config
fi

if [ ! -f /config/named.conf ]; then
    echo "kopie naar config"
    cp -frp ${GITHUB_CLONE_DIR}/dns/* /config
    sed "s/#LISTEN_ON#/${LISTEN_ON}/g" /config/named.conf -i
fi

mkdir -p /data/cache
chown named:named /data/cache
chmod 755 /data/cache

/usr/sbin/named -g -c /config/named.conf -u named &

fg %1
