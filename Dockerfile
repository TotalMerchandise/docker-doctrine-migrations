FROM alpine:3.12

ARG ALPINE_VERSION=3.12
ARG PHP_VERSION=8.0
ARG DOCTRINE_MIGRATIONS_VERSION=3.3.2
ARG COMPOSER_VERSION=2.1.0

ADD https://packages.whatwedo.ch/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
ADD configuration.yml /
ADD migrations-db.php /

VOLUME ["/data"]

WORKDIR /

RUN apk --update add ca-certificates \
    && echo "@cast https://packages.whatwedo.ch/php-alpine/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories \
    && apk add -U \
    curl \
    bash \
    php8@cast \
    php8-dev@cast \
    php8-common@cast \
    php8-apcu@cast \
    php8-gd@cast \
    php8-xmlreader@cast \
    php8-bcmath@cast \
    php8-ctype@cast \
    php8-curl@cast \
    php8-exif@cast \
    php8-iconv@cast \
    php8-intl@cast \
    php8-mbstring@cast \
    php8-opcache@cast \
    php8-openssl@cast \
    php8-pcntl@cast \
    php8-phar@cast \
    php8-session@cast \
    php8-xml@cast \
    php8-xsl@cast \
    php8-zip@cast \
    php8-zlib@cast \
    php8-dom@cast \
    php8-fpm@cast \
    php8-sodium@cast \
    php8-pdo_sqlite@cast \
    php8-pdo_mysql@cast \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv \
    && ln -s /usr/bin/php8 /usr/bin/php \
    && rm -rf /var/cache/apk/* \
    && curl -sS https://raw.githubusercontent.com/composer/getcomposer.org/bab7126c8f24c897a76f27c4bb3c8d6881dc7926/web/installer | php -- --install-dir=/usr/local/bin --version ${COMPOSER_VERSION} --filename=composer \
    && curl -sS -0L https://github.com/doctrine/migrations/archive/refs/tags/${DOCTRINE_MIGRATIONS_VERSION}.tar.gz -o migrations.tar.gz \
    && tar -zxvf migrations.tar.gz \
    && mv migrations-${DOCTRINE_MIGRATIONS_VERSION} migrations && cd migrations && bash build-phar.sh \
    && mkdir /data

ENTRYPOINT ["/migrations/bin/doctrine-migrations", "--configuration=/configuration.yml"]
