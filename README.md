1. docker-lnmp 项目帮助开发者快速构建本地开发环境，包括PHP等镜像并支持版本切换，不限操作系统；
2. PHP 支持 php7.2、php7.3、php7.4、php8.0 版本；
3. MySQL 支持 5.7 、8.0 版本；
4. Redis 支持 4.0 、5.0 、6.0 版本；

### 一. [docker install](https://github.com/ogenes/docker-lnmp/wiki/Docker-%E7%AE%80%E4%BB%8B%E5%8F%8A%E5%AE%89%E8%A3%85)

```
$ docker -v
Docker version 19.03.8, build afacb8b

$ docker-compose -v
docker-compose version 1.25.5, build 8a1c60f6

```

### 二. download
```$xslt
$ pwd
/d/www
$ git clone https://github.com/ogenes/docker-lnmp.git
```
### 三. init
```shell script
$ cd docker-lnmp
$ cp .env.example .env
```

### 四. run
```shell script
$ docker-compose up -d nginx
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                      NAMES
ba864491ac22        docker-lnmp_mysql   "docker-entrypoint.s…"   22 minutes ago      Up 6 seconds        0.0.0.0:3306->3306/tcp, 33060/tcp          mysql
68ca3dcdf667        docker-lnmp_nginx   "nginx -g 'daemon of…"   42 minutes ago      Up 3 seconds        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   nginx
9e46003ebe39        docker-lnmp_php     "docker-php-entrypoi…"   42 minutes ago      Up 4 seconds        0.0.0.0:9000->9000/tcp                     php
e1c96bbea465        docker-lnmp_redis   "docker-entrypoint.s…"   51 minutes ago      Up 5 seconds        0.0.0.0:6379->6379/tcp                     redis

$ cp nginx/conf.d/default.conf.example nginx/conf.d/default.conf

#绑定本机hosts
127.0.0.1 default.dev.com

访问 http://default.dev.com/ 得到响应 Hello Ogenes! 表示运行成功。

```

### 五. note
    默认版本为：
    PHP 7.4
    MySQL 5.7
    Redis 5.0
    可以通过修改 env 文件的 PHP_VERSION 、MYSQL_VERSION 、REDIS_VERSION 来选择其他版本
    
    项目目录默认为 docker-lnmp/www 目录
    可以通过修改 env 文件的 WEB_ROOT_PATH 来指定其他目录

    nginx 虚拟主机配置文件在 docker-lnmp/nginx/conf.d 目录内， 可以参考 default 项目配置。