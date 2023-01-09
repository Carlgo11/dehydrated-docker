FROM alpine

ENV CA="letsencrypt"
ENV PYTHONUNBUFFERED=1
ENV USERDATA="/persistent"
ENV TMP="/tmp"
ENV HOOK_PATH="hooks/cloudflare"

COPY config.toml /etc/dehydrated/config
WORKDIR /opt/dehydrated

# Download dehydrated & CF hook
ADD https://github.com/dehydrated-io/dehydrated/releases/download/v0.7.1/dehydrated-0.7.1.tar.gz $TMP
ADD https://github.com/walcony/letsencrypt-cloudflare-hook/archive/refs/heads/master.zip $TMP

# Run init script
COPY init.sh /
RUN sh /init.sh

# Fix CF hook
ADD https://gist.githubusercontent.com/Carlgo11/f0ab77b76ee4f9c0081aea46773654c1/raw/b34c0bf4774fb3fe79bcf8adc0402e54eb7d09c9/hook.py $HOOK_PATH
RUN chown 1000:1000 . /etc/dehydrated/ "$USERDATA" -R; chmod 700 "$HOOK_PATH"

USER 1000:1000
ENTRYPOINT dehydrated --register --accept-terms && dehydrated -c
