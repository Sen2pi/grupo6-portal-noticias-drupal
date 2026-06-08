$database_url = getenv('DATABASE_URL');
if ($database_url) {
  $parts = parse_url($database_url);
  $databases['default']['default'] = [
    'database' => isset($parts['path']) ? ltrim($parts['path'], '/') : '',
    'username' => $parts['user'] ?? '',
    'password' => $parts['pass'] ?? '',
    'prefix' => '',
    'host' => $parts['host'] ?? '127.0.0.1',
    'port' => (string) ($parts['port'] ?? '5432'),
    'namespace' => 'Drupal\\Core\\Database\\Driver\\pgsql',
    'driver' => 'pgsql',
  ];
}

$settings['hash_salt'] = getenv('DRUPAL_HASH_SALT') ?: $settings['hash_salt'];
$settings['config_sync_directory'] = $app_root . '/../config/sync';
<?php
$database_url = getenv('DATABASE_URL');
if ($database_url) {
  $parts = parse_url($database_url);
  $databases['default']['default'] = [
    'database' => isset($parts['path']) ? ltrim($parts['path'], '/') : '',
    'username' => $parts['user'] ?? '',
    'password' => $parts['pass'] ?? '',
    'prefix' => '',
    'host' => $parts['host'] ?? '127.0.0.1',
    'port' => (string) ($parts['port'] ?? '5432'),
    'namespace' => 'Drupal\\Core\\Database\\Driver\\pgsql',
    'driver' => 'pgsql',
  ];
}

$settings['hash_salt'] = getenv('DRUPAL_HASH_SALT') ?: $settings['hash_salt'];
$settings['config_sync_directory'] = $app_root . '/../config/sync';

$trusted_pattern = getenv('TRUSTED_HOST_PATTERN');
if ($trusted_pattern) {
  $settings['trusted_host_patterns'] = [$trusted_pattern];
}
$trusted_pattern = getenv('TRUSTED_HOST_PATTERN');
if ($trusted_pattern) {
  $settings['trusted_host_patterns'] = [$trusted_pattern];
}
