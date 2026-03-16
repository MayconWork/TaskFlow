#!/bin/sh
set -e

echo "Aguardando MySQL..."
until php -r "new PDO('mysql:host='.getenv('DB_HOST').';dbname='.getenv('DB_DATABASE'), getenv('DB_USERNAME'), getenv('DB_PASSWORD'));" 2>/dev/null; do
  sleep 2
done

php artisan package:discover --ansi
php artisan key:generate --no-interaction --force
php artisan migrate --no-interaction --force
php artisan storage:link --no-interaction --force
php artisan config:cache
php artisan route:cache

exec php-fpm