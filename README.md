

### 一. 安装docker

```
D:\www> docker -v
Docker version 19.03.5, build 633a0ea
```

### 二. 下载项目
```$xslt
git clone https://github.com/ogenes/docker-lnmp.git
```
### 三. RUN
```shell
cd docker-lnmp
cp .env.example .env
cp php/config/php.ini.example php/config/php.ini
cp nginx/conf.d/default.conf.example nginx/conf.d/default.conf
docker-compose up -d
```

### 项目目录
```shell
#当前目录
$ pwd
/d/www/docker-lnmp

#同级目录下的test项目, 在index
$ cat ../test/index.php
<?php
phpinfo();

#nginx示例配置 
    server_name  default.dev.com;
    root   /var/www/test;
    index  index.php index.html index.htm;

# 添加本地hosts
127.0.0.1 default.dev.com

访问 default.dev.com 即可
```
