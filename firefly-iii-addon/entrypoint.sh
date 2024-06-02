#!/usr/bin/with-contenv bashio
set -e

declare ingress_interface
declare ingress_port

ingress_port=$(bashio::addon.ingress_port)
ingress_interface=$(bashio::addon.ip_address)
sed -i "s/%%port%%/${ingress_port}/g" /etc/nginx/servers/ingress.conf
sed -i "s/%%interface%%/${ingress_interface}/g" /etc/nginx/servers/ingress.conf

export SITE_OWNER="$(bashio::config 'SITE_OWNER')"

# APP_KEY
export APP_KEY="$(bashio::config 'APP_KEY')"

# If not base64
if [[ ! "$APP_KEY" == *"base64"* ]]; then
    # Check APP_KEY format
    if [ ! "${#APP_KEY}" = 32 ]; then bashio::exit.nok "Your APP_KEY has ${#APP_KEY} instead of 32 characters"; fi
fi

# Backup APP_KEY file
bashio::log.info "Backuping APP_KEY to /config/addons_config/fireflyiii/APP_KEY_BACKUP.txt"
bashio::log.warning "Changing this value will require to reset your database"

# Get current app_key
mkdir -p /config/addons_config/fireflyiii
touch /config/addons_config/fireflyiii/APP_KEY_BACKUP.txt
CURRENT=$(sed -e '/^[<blank><tab>]*$/d' /config/addons_config/fireflyiii/APP_KEY_BACKUP.txt | sed -n -e '$p')

# Save if new
if [ "$CURRENT" != "$APP_KEY" ]; then
    echo "$APP_KEY" >>/config/addons_config/fireflyiii/APP_KEY_BACKUP.txt
fi

mkdir -p /config/addons_config/fireflyiii
mkdir -p /config/addons_config/fireflyiii/database

touch /config/addons_config/fireflyiii/database/database.sqlite

rm -rf /var/www/html/storage/database
ln -s /config/addons_config/fireflyiii/database /var/www/html/storage

mkdir -p /config/addons_config/fireflyiii/upload

rm -rf /var/www/html/storage/upload
ln -s /config/addons_config/fireflyiii/upload /var/www/html/storage

# Updating permissions
chown -R www-data:www-data /config/addons_config/fireflyiii
find /config/addons_config/fireflyiii -type f -exec chmod 644 {} \;
find /config/addons_config/fireflyiii -type d -exec chmod 775 {} \;

cd /var/www/html

chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache

php artisan migrate --seed
php artisan firefly-iii:decrypt-all
php artisan route:clear
php artisan twig:clean
php artisan view:clear
php artisan clear-compiled
php artisan cache:clear
php artisan firefly-iii:upgrade-database
php artisan firefly-iii:correct-database
php artisan firefly-iii:report-integrity
php artisan firefly-iii:laravel-passport-keys
php artisan firefly:instructions update

apachectl -D FOREGROUND