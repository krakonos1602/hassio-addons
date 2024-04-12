FROM lukascerveny/testing:aarch64-hassio-mealie

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs /
RUN chmod a+x /etc/cont-init.d/nginx.sh \
    && chmod a+x /etc/services.d/nginx/*

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

CMD [ "/entrypoint.sh" ]