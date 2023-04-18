FROM nginx:1.14

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
    git \
    vim \
    wget \
    net-tools \
    snapd \
  && rm -rf /var/lib/apt/lists/* \

#certbot
RUN snap install core; snap refresh core
RUN snap install --classic certbot
RUN ln -s /snap/bin/certbot /usr/bin/certbot

# 更改权限
RUN mkdir /var/www \
    && chown -R www-data:www-data /var/www/ /var/log/nginx/
