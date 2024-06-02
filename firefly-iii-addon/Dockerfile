ARG BUILD_FROM
FROM $BUILD_FROM

RUN rm -rf /etc/apache2/sites*

COPY nginx /etc/nginx
COPY sites-enabled /etc/apache2/sites-enabled

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

CMD [ "/entrypoint.sh" ]
