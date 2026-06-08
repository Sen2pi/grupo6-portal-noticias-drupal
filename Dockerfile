FROM php:8.3-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    libzip-dev \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j "$(nproc)" \
    gd \
    intl \
    opcache \
    pdo_pgsql \
    zip

RUN a2enmod rewrite headers

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

RUN composer create-project --no-interaction drupal/recommended-project:^11 . \
  && composer require --no-interaction \
    drupal/admin_toolbar \
    drupal/pathauto \
    drupal/metatag \
    drupal/redirect \
    drupal/simple_sitemap \
    drupal/honeypot

RUN cp web/sites/default/default.settings.php web/sites/default/settings.php \
  && mkdir -p web/sites/default/files \
  && chown -R www-data:www-data web/sites/default \
  && chmod 664 web/sites/default/settings.php

COPY docker/settings.render.php /var/www/html/web/sites/default/settings.render.php
RUN printf "\nif (file_exists(__DIR__ . '/settings.render.php')) { require __DIR__ . '/settings.render.php'; }\n" >> /var/www/html/web/sites/default/settings.php

COPY docker/apache-vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
