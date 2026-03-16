FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libonig-dev libpng-dev libjpeg-dev libfreetype6-dev \
    libxml2-dev zlib1g-dev libicu-dev wget curl \
  && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath intl zip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "upload_max_filesize=20M\npost_max_size=25M\nmemory_limit=256M" \
    > /usr/local/etc/php/conf.d/taskflow.ini

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock* ./
RUN php -d memory_limit=-1 /usr/bin/composer install \
    --no-interaction --prefer-dist --no-scripts --no-autoloader

COPY . .

RUN php -d memory_limit=-1 /usr/bin/composer dump-autoload --optimize --no-scripts

RUN chown -R www-data:www-data /var/www/html \
  && mkdir -p storage/app/public bootstrap/cache \
  && chmod -R 775 storage bootstrap/cache

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]