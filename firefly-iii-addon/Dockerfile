ARG BUILD_FROM
FROM $BUILD_FROM
ARG FIREFLY_VERSION

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    nginx php php-bcmath php-intl php-curl php-zip php-gd php-xml php-mbstring php-sqlite3 \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/html && wget https://github.com/firefly-iii/firefly-iii/archive/refs/tags/v$FIREFLY_VERSION.tar.gz && tar -xzf v$FIREFLY_VERSION.tar.gz && mv firefly-iii-$FIREFLY_VERSION /var/www/html && rm -rf /var/www/html/storage/database && rm -rf /var/www/html/storage/upload && chmod a+x /var/www/html/artisan

COPY rootfs /
RUN chmod a+x /etc/cont-init.d/nginx.sh \
    && chmod a+x /etc/services.d/nginx/*

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

CMD [ "/entrypoint.sh" ]
