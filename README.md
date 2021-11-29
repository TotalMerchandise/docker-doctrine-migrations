# Docker Doctrine Migrations

A simple Docker image that allows Doctrine Migrations to be executed as a standalone step in a CI Pipeline (such as GitHub Actions or GitLab CI).


## Example usage
```
docker pull ghcr.io/totalmerchandise/docker-doctrine-migrations:main
```

```
docker run \
  -v $(pwd)/app/src/Migrations:/data \
  -e MIGRATION_DRIVER=pdo_mysql \
  -e MIGRATION_DATABASE=my_database_name \
  -e MIGRATION_USERNAME=my_username \
  -e MIGRATION_PASSWORD=my_password \
  -e MIGRATION_HOSTNAME=my_database_host \
  ghcr.io/totalmerchandise/docker-doctrine-migrations:main \
  migrations:migrate
```

## Breakdown
* Migrations are in the folder app/src/Migrations (relative to the current working directory)
* We connect to the database using the pdo_mysql driver
* The database name is 'my_database_name'
* We have database read/write access as the user 'my_username'
* The password for 'my_username' is 'my_password'
* The database is reachable at the hostname 'my_database_host'
* I wish to run the command 'migrations:migrate'

For additional commands referer to the official [Doctrine Migrations Documentation](https://www.doctrine-project.org/projects/doctrine-migrations/en/3.3/index.html)
