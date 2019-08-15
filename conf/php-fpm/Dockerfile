FROM php:7.2.12-fpm-alpine
LABEL oshou <adf1985adf@gmail.com>
USER root
RUN echo "install mysql mysqli pdo driver" \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd

# Install recommended extensions for Symfony
# RUN apk add --update icu-dev \
#     && docker-php-ext-install intl \
#     && docker-php-ext-install sockets \
#     && apk add --update \
# 		libevent-dev \
# 		openssl-dev \
# 	&& pecl install event \
#     && docker-php-ext-enable event \

RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-install opcache && \
  docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd
RUN apk update \
    && apk add --no-cache git curl libmcrypt libmcrypt-dev icu-dev imagemagick-dev \
    libxml2-dev g++ make autoconf \
    && docker-php-source extract \
    && pecl install redis imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable opcache \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-source delete

RUN apk add -U --no-cache nano bash wget

RUN apk del --purge autoconf g++ libtool make
RUN rm -rf /tmp/* /var/cache/apk/*

# Install PHP Extensions (igbinary & memcached)
RUN apk add --no-cache --update libmemcached-libs zlib
RUN set -xe && \
    cd /tmp/ && \
    apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS && \
    apk add --no-cache --update --virtual .memcached-deps zlib-dev libmemcached-dev cyrus-sasl-dev && \
# Install igbinary (memcached's deps)
    pecl install igbinary && \
# Install memcached
    ( \
        pecl install --nobuild memcached && \
        cd "$(pecl config-get temp_dir)/memcached" && \
        phpize && \
        ./configure --enable-memcached-igbinary && \
        make -j$(nproc) && \
        make install && \
        cd /tmp/ \
    ) && \
# Enable PHP extensions
    docker-php-ext-enable igbinary memcached && \
    rm -rf /tmp/* && \
    apk del .memcached-deps .phpize-deps

RUN ln -s /usr/local/bin/php /usr/bin/php

# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /composer

# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# NODEJS
RUN apk add --update nodejs npm yarn && rm -rf /var/cache/apk/* 

RUN rm -rf /tmp/* /var/cache/apk/*

EXPOSE 9000
