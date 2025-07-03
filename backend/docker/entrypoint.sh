#!/bin/bash

# Wait for database to be ready
echo "Waiting for database..."
while ! nc -z mysql 3306; do
  sleep 1
done

echo "Database is ready!"

# Run Laravel setup commands
php artisan key:generate --force
php artisan config:cache
php artisan migrate --force
php artisan db:seed --force
php artisan storage:link

# Start supervisor
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf 