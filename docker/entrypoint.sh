#!/usr/bin/env sh
set -eu

settings_file="/var/www/html/web/sites/default/settings.php"
include_line="if (file_exists(__DIR__ . '/settings.render.php')) { require __DIR__ . '/settings.render.php'; }"

if [ -f "$settings_file" ]; then
  if ! grep -Fq "$include_line" "$settings_file"; then
    printf "\n%s\n" "$include_line" >> "$settings_file"
  fi
fi

mkdir -p /var/www/html/web/sites/default/files
chown -R www-data:www-data /var/www/html/web/sites/default/files

exec "$@"
