#!/bin/sh

# Install dependencies
apk add --no-cache curl git python3 py3-pip openssl tar bash && ln -sf python3 /usr/bin/python

# Decompress dehydrated.tar.gz
tar xf /tmp/dehydrated-*.tar.gz --strip=1 -C .

# Download CF hook
git clone https://github.com/walcony/letsencrypt-cloudflare-hook hooks/cloudflare
pip3 install --ignore-installed -r hooks/cloudflare/requirements.txt

# Prepare paths
mkdir -p /tmp/certs/ /etc/dehydrated/archive
