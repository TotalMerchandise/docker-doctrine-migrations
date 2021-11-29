<?php

use Doctrine\DBAL\DriverManager;

return DriverManager::getConnection([
    'dbname' => getenv('MIGRATION_DATABASE'),
    'user' => getenv('MIGRATION_USERNAME'),
    'password' => getenv('MIGRATION_PASSWORD'),
    'host' => getenv('MIGRATION_HOSTNAME'),
    'driver' => getenv('MIGRATION_DRIVER'),
]);
