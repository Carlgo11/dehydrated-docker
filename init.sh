#!/bin/sh

# Install dependencies
apk add --no-cache curl python3 py3-pip openssl tar bash && ln -sf python3 /usr/bin/python

# Decompress dehydrated.tar.gz
tar xf /tmp/dehydrated-*.tar.gz --strip=1 -C .
ln -s "$(pwd)/dehydrated" /usr/local/bin/

# Decompress hook
unzip /tmp/master.zip -d /tmp/ && mkdir hooks && mv /tmp/letsencrypt-cloudflare-hook-master hooks/cloudflare
pip3 install --ignore-installed -r hooks/cloudflare/requirements.txt

# Prepare paths
mkdir -p /persistent
