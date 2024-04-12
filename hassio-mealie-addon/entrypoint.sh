#!/usr/bin/with-contenv bashio

grep -rl "/app/data" /app | xargs sed -i 's|/app/data|/config/addons_config/mealie_data|g' && sed -i "s|change_user$|# change_user|g" /app/run.sh

export ALLOW_SIGNUP=$(bashio::config 'ALLOW_SIGNUP')
export BASE_URL=$(bashio::config 'BASE_URL')
export SMTP_HOST=$(bashio::config 'SMTP_HOST')
export SMTP_PORT=$(bashio::config 'SMTP_PORT')
export SMTP_FROM_EMAIL=$(bashio::config 'BASE_URL')
export SMTP_USER=$(bashio::config 'BASE_URL')
export SMTP_PASSWORD=$(bashio::config 'BASE_URL')

/app/run.sh