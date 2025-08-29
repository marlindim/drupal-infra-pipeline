FROM php:8.1-apache
RUN docker-php-ext-install mysqli
COPY ./drupal /var/www/html/
