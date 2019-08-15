FROM php:7.2.12-fpm-alpine
LABEL oshou <adf1985adf@gmail.com>
USER root

ARG USER=root
ARG PASSWORD=root

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
    && apk add --no-cache git curl libmcrypt libmcrypt-dev openssh-client icu-dev \
    libxml2-dev g++ make autoconf \
    && docker-php-source extract \
    && pecl install xdebug redis \
    && docker-php-ext-enable xdebug redis \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk add -U --no-cache openssh nano bash

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "${USER}:${PASSWORD}" | chpasswd
RUN sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config

RUN sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
RUN ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
#RUN HOST_IP="$(/sbin/ip route|awk '/default/ { print $3 }')" \
#    && sed -i "$ a\xdebug.remote_host=${HOST_IP}" /usr/local/etc/php/conf.d/xdebug.ini

RUN apk del --purge autoconf g++ libtool make
RUN rm -rf /tmp/* /var/cache/apk/*

COPY ./start.sh /root/start.sh
RUN chmod +x /root/start.sh
RUN ln -s /usr/local/bin/php /usr/bin/php
# NODEJS
RUN apk add --update nodejs npm yarn && rm -rf /var/cache/apk/*  

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

CMD ["/root/start.sh"]

EXPOSE 22 9000 9001
