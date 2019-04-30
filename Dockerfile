FROM php:7-apache

# change document root to load website from public directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN apt update && apt install curl \
  && curl -s https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && docker-php-ext-install mysqli \
  && a2enmod rewrite \
  && a2enmod headers \
  && service apache2 restart \
  && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
  && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
