ARG BUILD_ARCH
FROM ghcr.io/home-assistant/${BUILD_ARCH}-base-debian:bookworm
ARG FIREFLY_VERSION

RUN apt update \
    && apt install --no-install-recommends -y wget curl lsb-release apt-transport-https \
    && curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    apache2 php8.3 php8.3-{bcmath,intl,curl,zip,gd,xml,mbstring,sqlite3} libapache2-mod-php8.3 \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/html && wget -q https://github.com/firefly-iii/firefly-iii/releases/download/v${FIREFLY_VERSION}/FireflyIII-v${FIREFLY_VERSION}.tar.gz && mkdir /var/www/html && tar -xzf FireflyIII-v${FIREFLY_VERSION}.tar.gz -C /var/www/html && rm FireflyIII-v${FIREFLY_VERSION}.tar.gz && rm -rf /var/www/html/storage/database && rm -rf /var/www/html/storage/upload && rm -rf /var/www/html/vendor && chmod a+x /var/www/html/artisan

RUN sed -i -r 's@Errorlog .*@Errorlog /dev/stderr@i' /etc/apache2/apache2.conf
RUN echo "Transferlog /dev/stdout" >> /etc/apache2/apache2.conf
RUN echo "LoadModule rewrite_module /usr/lib/apache2/modules/mod_rewrite.so" >> /etc/apache2/apache2.conf
RUN echo "LoadModule proxy_module /usr/lib/apache2/modules/mod_proxy.so" >> /etc/apache2/apache2.conf
RUN echo "LoadModule proxy_http_module /usr/lib/apache2/modules/mod_proxy_http.so" >> /etc/apache2/apache2.conf
RUN echo "LoadModule headers_module /usr/lib/apache2/modules/mod_headers.so" >> /etc/apache2/apache2.conf

RUN chown -R www-data:www-data /var/www/html && find /var/www/html -type f -exec chmod 644 {} \; && find /var/www/html -type d -exec chmod 775 {} \;

WORKDIR /var/www/html
RUN wget -q -O composer-setup.php https://getcomposer.org/installer && php composer-setup.php && rm composer-setup.php && mv composer.phar /usr/local/bin/composer

ENV APP_KEY TestTestTestTestTestTestTestTest

RUN composer install

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    locales-all \
    && rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.source="https://github.com/krakonos1602/hassio-addons"