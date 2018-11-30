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

RUN rm -rf /tmp/* /var/cache/apk/*
