#!/usr/bin/with-contenv bashio
declare ingress_interface
declare ingress_port
declare base_subpath

ingress_port=$(bashio::addon.ingress_port)
ingress_interface=$(bashio::addon.ip_address)
sed -i "s/%%port%%/${ingress_port}/g" /etc/nginx/servers/ingress.conf
sed -i "s/%%interface%%/${ingress_interface}/g" /etc/nginx/servers/ingress.conf

base_subpath=$(bashio::config 'BASE_SUBPATH')
sed -i "s/%%subpath%%/${base_subpath}/g" /etc/nginx/servers/default.conf
