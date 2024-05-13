FROM ghcr.io/home-assistant/aarch64-base-debian

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs /
RUN chmod a+x /etc/cont-init.d/nginx.sh \
    && chmod a+x /etc/services.d/nginx/*