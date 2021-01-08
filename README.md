此项目帮助PHP开发者快速构建本地开发环境， 不建议用于生产环境。

### 一. [安装docker](https://github.com/ogenes/docker-lnmp/wiki/Docker-%E7%AE%80%E4%BB%8B%E5%8F%8A%E5%AE%89%E8%A3%85)

```
$ docker -v
Docker version 19.03.8, build afacb8b

$ docker-compose -v
docker-compose version 1.25.5, build 8a1c60f6

```

### 二. 下载项目
```$xslt
$ pwd
/d/www
$ git clone https://github.com/ogenes/docker-lnmp.git
```
### 三. RUN
```shell
$ cd docker-lnmp
$ cp .env.example .env
$ cp php/config/php.ini.example php/config/php.ini
$ cp nginx/conf.d/default.conf.example nginx/conf.d/default.conf
$ docker-compose up -d

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                      NAMES
e14287a930cb        docker-lnmp_nginx   "nginx -g 'daemon of…"   6 minutes ago       Up 2 minutes        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   nginx
07d188418a15        docker-lnmp_php     "docker-php-entrypoi…"   6 minutes ago       Up 6 minutes        0.0.0.0:9000->9000/tcp                     php
5af89318dd8f        redis               "docker-entrypoint.s…"   19 minutes ago      Up 13 minutes       0.0.0.0:6379->6379/tcp                     redis
2d7d22eaa938        mysql:5.7           "docker-entrypoint.s…"   19 minutes ago      Up 13 minutes       0.0.0.0:3306->3306/tcp, 33060/tcp          mysql

$ cd -
```

### 四. 项目目录
默认设置为 ./docker-lnmp/www 目录， 也可修改yml文件的volumes来修改项目目录。

以 default 项目为例：
```shell
#当前目录位置
$ pwd
/d/www/docker-lnmp

#Nginx 配置文件位置
./docker-lnmp/nginx/conf.d/default.conf

#代码位置 ./docker-lnmp/www/default/*

$ cat ./docker-lnmp/www/default/index.php
<?php

echo 'Hello Ogenes!';

# 添加本地hosts
127.0.0.1 default.dev.com

#访问 default.dev.com 输出 Hello Ogenes! 即可
```
需要添加新的项目时， 在 ./docker-lnmp/www/ 下新建 appName/ 项目目录， 然后在 ./docker-lnmp/nginx/conf.d/ 下创建 appName.conf 配置文件即可。
