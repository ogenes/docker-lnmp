ARG VERSION
FROM php:${VERSION}-fpm

LABEL maintainer="ogenes.yi@gmail.com"

# 复制时区配置
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装基础
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


# 安装PHP扩展
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
        mysqli \
        pcntl \
        pdo_mysql \
        sockets \
        zip \
        soap \
        exif \
  && docker-php-ext-install opcache \
  && docker-php-ext-enable opcache

ARG VERSION
RUN if [ "$VERSION" = "7.1" ] || [ "$VERSION" = "7.2" ] || [ "$VERSION" = "7.3" ]; then \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/lib --with-freetype-dir=/usr/include/freetype2 \
    && docker-php-ext-install gd; \
elif [ "$VERSION" = "7.4" ] || [ "$VERSION" = "8.0" ]; then \
    docker-php-ext-configure gd --with-jpeg=/usr/lib --with-freetype=/usr/include/freetype2 \
    && docker-php-ext-install gd; \
fi

# 安装 Redis 扩展
RUN pecl install -o -f redis && docker-php-ext-enable redis

# 安装 grpc 扩展
#RUN pecl install -o -f grpc && docker-php-ext-enable grpc

# 安装 protobuf 扩展
#RUN pecl install -o -f protobuf  && docker-php-ext-enable protobuf

# 安装 memcached 扩展
RUN pecl install -o -f memcached  && docker-php-ext-enable memcached

# 安装 swoole 扩展
#RUN pecl install -o -f swoole && docker-php-ext-enable swoole

RUN rm -rf /tmp/pear

# 安装 Composer
ENV COMPOSER_HOME /var/www/.composer
#RUN curl -sS https://install.phpcomposer.com/installer | php -- --install-dir=/usr/bin --filename=composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#RUN curl -sS https://install.phpcomposer.com/installer | php -- --install-dir=/usr/local/bin --filename=composer1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer1
RUN composer1 config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer1 self-update --1

RUN chown -R www-data:www-data /var/www/

RUN mkdir -p /var/log/php

RUN mkdir -p $COMPOSER_HOME/cache

VOLUME $COMPOSER_HOME
WORKDIR /var/www
