FROM php:5.6.40-fpm

LABEL maintainer="ogenes.yi@gmail.com"

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    apt-utils \
    curl \
    sudo \
    iputils-ping \
    libicu-dev \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libzip-dev \
    libonig-dev \
    libjpeg62-turbo-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    zlib1g-dev \
    libxml2-dev \
    libbz2-dev \
    graphviz \
    git \
    vim \
    wget \
    net-tools \
    zip \
    unzip \
    openssh-server \
    openssh-client \
    subversion \
  && rm -rf /var/lib/apt/lists/*


RUN docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
    && docker-php-ext-configure mbstring --enable-mbstring \
    && docker-php-ext-configure soap --enable-soap \
    && docker-php-ext-configure exif --enable-exif \
    && docker-php-ext-install \
        bcmath \
        intl \
        mbstring \
        mysql \
        mysqli \
        pcntl \
        pdo_mysql \
        sockets \
        zip \
        soap \
        exif \
  && docker-php-ext-install opcache \
  && docker-php-ext-enable opcache

ARG EXT_GD
RUN if $EXT_GD; then \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/lib --with-freetype-dir=/usr/include/freetype2 \
        && docker-php-ext-install gd;\
fi

ARG EXT_REDIS
RUN if $EXT_REDIS; then \
    pecl install -o -f https://pecl.php.net/get/redis-4.0.0.tgz && docker-php-ext-enable redis; \
fi

ARG EXT_GRPC
RUN if $EXT_GRPC; then \
    pecl install -o -f https://pecl.php.net/get/grpc-1.33.1.tgz && docker-php-ext-enable grpc; \
fi

ARG EXT_PROTOBUF
RUN if $EXT_PROTOBUF; then \
    pecl install -o -f https://pecl.php.net/get/protobuf-3.12.0.tgz  && docker-php-ext-enable protobuf; \
fi

ARG EXT_MEMCACHED
RUN if $EXT_MEMCACHED; then \
    pecl install -o -f https://pecl.php.net/get/memcached-2.1.0.tgz  && docker-php-ext-enable memcached; \
fi

ARG EXT_SWOOLED
RUN if $EXT_SWOOLED; then \
    pecl install -o -f swoole && docker-php-ext-enable swoole; \
fi

RUN rm -rf /tmp/pear

ENV COMPOSER_HOME /var/www/.composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer1
RUN composer1 config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer1 self-update --1

RUN chown -R www-data:www-data /var/www/

RUN mkdir -p /var/log/php

RUN mkdir -p $COMPOSER_HOME/cache

VOLUME $COMPOSER_HOME
WORKDIR /var/www
