FROM php:7.4-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip

# install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Use the default development configuration
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# enable apache mod rewrite
RUN a2enmod rewrite headers proxy proxy_http

WORKDIR /var/www
RUN chown -R www-data.www-data .
