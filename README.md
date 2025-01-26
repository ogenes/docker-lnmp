1. docker-lnmp 项目帮助开发者快速构建本地开发环境，包括Nginx、PHP、MySQL、Redis 服务镜像，支持配置文件和日志文件映射，不限操作系统；
2. 此项目适合个人开发者本机部署，可以快速切换服务版本满足学习服务新版本的需求； 也适合团队中统一开发环境，设定好配置后一键部署， 便于提高团队开发效率；
3. PHP 支持多版本 包括php5.6、 php7.1、php7.2、php7.3、php7.4、php8.0、php8.1、php8.2、php8.3、php8.4 版本；
4. MySQL 支持 5.7 、8.0 版本；
5. Redis 支持 4.0 、5.0 、6.0 版本；
6. PHP 扩展包括了gd、grpc、redis、protobuf、memcached、swoole、kafka、imap等；

### 一. [install docker](https://github.com/ogenes/docker-lnmp/wiki/Docker-%E7%AE%80%E4%BB%8B%E5%8F%8A%E5%AE%89%E8%A3%85)

```
$ docker -v
Docker version 20.10.21, build baeda1f

$ docker-compose -v
Docker Compose version v2.12.2

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
#创建网络，指定子网与.env中配置一致
$ docker network create backend --subnet=172.19.0.0/16
18f511530214374896700ad3f179fb9180227fe4e5b6ccf7e9f8ed9b8602059c
$ docker network ls | grep backend
18f511530214   backend   bridge    local

#首次执行耗时较久，耐心等待
$ docker-compose up -d nginx php74 mysql redis
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                      NAMES
ba864491ac22        docker-lnmp_mysql   "docker-entrypoint.s…"   22 minutes ago      Up 6 seconds        0.0.0.0:3306->3306/tcp, 33060/tcp          mysql
68ca3dcdf667        docker-lnmp_nginx   "nginx -g 'daemon of…"   42 minutes ago      Up 3 seconds        0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   nginx
9e46003ebe39        docker-lnmp_php74   "docker-php74-entrypoi…"   42 minutes ago      Up 4 seconds        0.0.0.0:9074->9074/tcp                     php
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

### 六. note
    默认版本为：
    MySQL 5.7
    Redis 5.0
    可以通过修改 env 文件的 MYSQL_VERSION 、REDIS_VERSION 来选择其他版本
    MySQL 和 Redis 切换版本时，注意切换配置文件

    项目目录默认为 docker-lnmp/../www 目录
    可以通过修改 env 文件的 WEB_ROOT_PATH 来指定其他目录

    nginx 虚拟主机配置文件在 docker-lnmp/nginx/conf.d 目录内， 可以参考 default 项目配置。

### 七. restart | down | rebuild

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

### 目录结构

```
├── LICENSE
├── README.md
├── compose.yml
├── mysql
         ├── Dockerfile
         └── docker.cnf
├── nginx
         ├── Dockerfile
         ├── conf.d
                  ├── default.conf
                  ├── fpm
                           ├── php56-fpm
                           ├── php71-fpm
                           ├── php72-fpm
                           ├── php73-fpm
                           ├── php74-fpm
                           ├── php80-fpm
                           └── php81-fpm
         ├── nginx.conf
├── php56
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
├── php71
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
├── php72
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
├── php73
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
├── php74
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
├── php80
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
├── php81
         ├── Dockerfile
         └── config
             ├── php-fpm.conf
             ├── php-fpm.d
                      ├── www.conf
                      └── zz-docker.conf
             └── php.ini
└── redis
├── Dockerfile
├── redis4.conf
├── redis5.conf
└── redis6.conf

```

### Certbot 申请免费的ssl证书
1. 先配置http可访问， 以 test.ogenes.cn 为例
```shell
[root@ogenes01 docker-lnmp]# pwd
/data/docker-lnmp
[root@ogenes01 docker-lnmp]# vim nginx/conf.d/test.conf
server {
    listen 80;
    listen [::]:80;

    server_name test.ogenes.cn;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        charset utf-8;
        default_type text/html;
        return 200 'Hello Ogenes Test!';
    }
}

[root@ogenes01 docker-lnmp]# docker-compose restart nginx
[+] Running 1/1
 ⠿ Container nginx  Started
[root@ogenes01 docker-lnmp]# curl test.ogenes.cn
Hello Ogenes Test!
```
2. 申请ssl证书
```shell
[root@ogenes01 docker-lnmp]# docker-compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d test.ogenes.cn
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Requesting a certificate for test.ogenes.cn

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/test.ogenes.cn/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/test.ogenes.cn/privkey.pem
This certificate expires on 2023-07-18.
These files will be updated when the certificate renews.

NEXT STEPS:
- The certificate will need to be renewed before it expires. Certbot can automatically renew the certificate in the background, but you may need to take steps to enable that functionality. See https://certbot.org/renewal-setup for instructions.
We were unable to subscribe you the EFF mailing list because your e-mail address appears to be invalid. You can try again later by visiting https://act.eff.org.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
[root@ogenes01 docker-lnmp]#
```

3. 修改nginx配置，支持https
```shell
[root@ogenes01 docker-lnmp]# vim nginx/conf.d/test.conf
server {
    listen 80;
    listen [::]:80;

    server_name test.ogenes.cn;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://test.ogenes.cn$request_uri;
    }
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name test.ogenes.cn;

    ssl_certificate /etc/nginx/ssl/live/test.ogenes.cn/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/test.ogenes.cn/privkey.pem;

    location / {
        charset utf-8;
        default_type text/html;
        return 200 'Hello Ogenes Test Https!';
    }
}
[root@ogenes01 docker-lnmp]# docker-compose restart nginx
[+] Running 1/1
 ⠿ Container nginx  Started
[root@ogenes01 docker-lnmp]# curl https://test.ogenes.cn
Hello Ogenes Test Https!
```
![image-20230419175534350](https://img.ogenes.cn/img/2023/image-20230419175534350.png)

4. 配置计划任务，每个月月初自动刷新
```shell
#更新https证书
1 1 1 * * cd /data/docker-lnmp && docker-compose run --rm certbot renew >> /dev/null 2>&1
```
