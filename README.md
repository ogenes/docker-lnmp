1. docker-lnmp 项目帮助开发者快速构建本地开发环境，包括Nginx、PHP、MySQL、Redis、MongoDB服务镜像，支持服务版本切换，并支持配置文件和日志文件映射，不限操作系统；
2. 此项目适合个人开发者本机部署，可以快速切换服务版本满足学习服务新版本的需求； 也适合团队中统一开发环境，设定好配置后一键部署， 便于提高团队开发效率；
2. PHP 支持 php7.2、php7.3、php7.4、php8.0 版本；
3. MySQL 支持 5.7 、8.0 版本；
4. Redis 支持 4.0 、5.0 、6.0 版本；

### 目录结构

```
├─data                      数据文件
│  ├─mysql                      mysql文件目录
│  │  ├─mysql
│  │  ├─performance_schema
│  │  ├─sys
│  │  ├─*
│  ├─redis*                     redis文件目录
├─logs                      日志文件
│  ├─nginx                      nginx日志
│  │      access.log
│  │      default.access.log
│  │      default.error.log
│  │
│  └─php                        php日志
│          fpm.access.log
│          fpm.error_log
│          php-fpm.log
│          www.slow.log
│─mongo
│      Dockerfile
│      mongod.conf              mongo配置
│
├─mysql
│      docker.cnf               mysql配置
│      Dockerfile
│
├─nginx
│  │  Dockerfile
│  │  nginx.conf                nginx配置
│  │
│  └─conf.d                     nginx虚拟主机配置
│          default.conf
│          default.conf.example
│
├─php
│  │  Dockerfile
│  │
│  └─config                     php配置
│      │  php-fpm.conf
│      │  php.ini
│      │
│      └─php-fpm.d
│              docker.conf
│              www.conf
│              zz-docker.conf
│
├─redis
│      Dockerfile
│      redis4.conf              redis配置
│      redis5.conf
│      redis6.conf
│
└─www                           默认项目
    ├─.composer
    └─default
            index.php
```

### 一. [install docker](https://github.com/ogenes/docker-lnmp/wiki/Docker-%E7%AE%80%E4%BB%8B%E5%8F%8A%E5%AE%89%E8%A3%85)

```
$ docker -v
Docker version 19.03.8, build afacb8b

$ docker-compose -v
docker-compose version 1.25.5, build 8a1c60f6

```

### 二. download
```$xslt
$ pwd
/d/app
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
```

### 五. test
```
$ cp nginx/conf.d/default.conf.example nginx/conf.d/default.conf
$ docker-compose restart nginx

#绑定本机hosts
127.0.0.1 default.dev.com

```
访问 http://default.dev.com/ 得到响应 Hello Ogenes! 表示运行成功。

![QQ截图20210114105752.png](https://i.loli.net/2021/01/14/NPTJhEgcszFZaOp.png)

### 五. note
    默认版本为：
    PHP 7.4
    MySQL 5.7
    Redis 5.0
    可以通过修改 env 文件的 PHP_VERSION 、MYSQL_VERSION 、REDIS_VERSION 来选择其他版本
    MySQL 和 Redis 切换版本时，注意切换配置文件
    
    项目目录默认为 docker-lnmp/www 目录
    可以通过修改 env 文件的 WEB_ROOT_PATH 来指定其他目录

    nginx 虚拟主机配置文件在 docker-lnmp/nginx/conf.d 目录内， 可以参考 default 项目配置。

### 六. restart | down | rebuild

```shell script

#修改配置文件后重启即可
$ docker-compose restart nginx php
Restarting nginx ... done
Restarting php   ... done

# 修改 dockerfile 或者 env 文件之后 rebuild 可生效
$ docker-compose up -d --build php nginx mysql

# 停止
$ docker-compose stop

# 停止并删除容器
$ docker-compose down

# 停止并删除容器+镜像
$ docker-compose down --rmi all

```


