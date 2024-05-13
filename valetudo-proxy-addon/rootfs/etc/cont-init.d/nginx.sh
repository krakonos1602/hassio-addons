#!/usr/bin/with-contenv bashio
declare backend_url
backend_url=$(bashio::config 'LOCAL_URL')
sed -i "s|%%backend_url%%|${backend_url}|g" /etc/nginx/servers/ingress.conf
