FROM php:7.4-fpm

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
  && docker-php-ext-configure gd \
    --with-jpeg=/usr/lib \
    --with-freetype=/usr/include/freetype2 && \
    docker-php-ext-install gd \
  && docker-php-ext-install opcache \
  && docker-php-ext-enable opcache

# 安装 Redis 扩展
RUN cd /tmp \
    && wget https://github.com/edtechd/phpredis/archive/php7.zip \
    && unzip php7.zip \
    && cd phpredis-php7 \
    && phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config  \
    && make && make install \
	&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/docker-php-ext-redis.ini \
	&& rm -rf /tmp/phpredis-php7 \
	&& rm /tmp/php7.zip

# 安装 Composer
ENV COMPOSER_HOME /var/www/.composer
RUN curl -sS https://install.phpcomposer.com/installer | php -- --install-dir=/usr/bin --filename=composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer self-update

RUN chown -R www-data:www-data /var/www/

RUN mkdir -p /var/log/php

RUN mkdir -p $COMPOSER_HOME/cache

VOLUME $COMPOSER_HOME
WORKDIR /var/www
