#!/bin/sh

# Install dependencies
apk add --no-cache curl python3 py3-pip openssl tar bash && ln -sf python3 /usr/bin/python

# Decompress dehydrated.tar.gz
tar xf "${TMP}"/dehydrated-*.tar.gz --strip=1 -C "$(pwd)"
ln -s "$(pwd)/dehydrated" /usr/local/bin/

# Decompress hook
unzip "$TMP/master.zip" -d "$TMP" && mkdir hooks && mv "$TMP/letsencrypt-cloudflare-hook-master" "${HOOK_PATH}"
pip3 install --ignore-installed -r "${HOOK_PATH}/requirements.txt"

# Prepare paths
mkdir -p "$USERDATA"

# Remove dev dependencies
apk del --purge py3-pip tar
