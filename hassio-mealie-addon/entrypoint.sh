#!/usr/bin/with-contenv bashio

grep -rl "/app/data" /app | xargs sed -i 's|/app/data|/config/addons_config/mealie_data|g' && sed -i "s|change_user$|# change_user|g" /app/run.sh

export ALLOW_SIGNUP=$(bashio::config 'ALLOW_SIGNUP')
export BASE_URL=$(bashio::config 'BASE_URL')
export SMTP_HOST=$(bashio::config 'SMTP_HOST')
export SMTP_PORT=$(bashio::config 'SMTP_PORT')
export SMTP_FROM_EMAIL=$(bashio::config 'SMTP_FROM_EMAIL')
export SMTP_USER=$(bashio::config 'SMTP_USER')
export SMTP_PASSWORD=$(bashio::config 'SMTP_PASSWORD')
export OPENAI_BASE_URL=$(bashio::config 'OPENAI_BASE_URL')
export OPENAI_API_KEY=$(bashio::config 'OPENAI_API_KEY')
export OPENAI_MODEL=$(bashio::config 'OPENAI_MODEL')
export OPENAI_WORKERS=$(bashio::config 'OPENAI_WORKERS')
export OPENAI_SEND_DATABASE_DATA=$(bashio::config 'OPENAI_SEND_DATABASE_DATA')

/app/run.sh