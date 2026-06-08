#!/usr/bin/env sh
set -eu

mkdir -p /var/www/html/web/sites/default/files
chown -R www-data:www-data /var/www/html/web/sites/default/files

exec "$@"
