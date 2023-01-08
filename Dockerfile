FROM alpine

ENV PYTHONUNBUFFERED=1
ENV BASEDIR="/etc/dehydrated/"

WORKDIR dehydrated

# Download dehydrated
ADD https://github.com/dehydrated-io/dehydrated/releases/download/v0.7.1/dehydrated-0.7.1.tar.gz /tmp/
COPY config.toml /etc/dehydrated/config

# Run init script
COPY init.sh /
RUN sh /init.sh

# Fix CF hook
ADD https://gist.githubusercontent.com/Carlgo11/f0ab77b76ee4f9c0081aea46773654c1/raw/b34c0bf4774fb3fe79bcf8adc0402e54eb7d09c9/hook.py hooks/cloudflare/
RUN chown 1000:1000 . /tmp/certs/ /etc/dehydrated/ -R; \
    chmod 700 hooks/cloudflare/hook.py

USER 1000:1000
ENTRYPOINT ./dehydrated --register --accept-terms; ./dehydrated -c
