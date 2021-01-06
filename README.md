此项目帮助PHP开发者快速构建本地开发环境， 不建议用于生产环境。

### 一. [安装docker](https://github.com/ogenes/docker-lnmp/wiki/Docker-%E7%AE%80%E4%BB%8B%E5%8F%8A%E5%AE%89%E8%A3%85)

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

### 四. 项目目录
默认设置为 docker-lnmp 同级目录， 也可修改yml文件的volumes来修改项目目录。
```
      # 项目代码 映射容器的 /var/www/ 目录
      - ../:/var/www/
```

以test项目为例
```shell
#当前目录
$ pwd
/d/www/docker-lnmp

#同级目录下的test项目
$ cat ../test/index.php
<?php
phpinfo();

#nginx示例配置 
    server_name  default.dev.com;
    root   /var/www/test;
    index  index.php index.html index.htm;

# 添加本地hosts
127.0.0.1 default.dev.com

#访问 default.dev.com 即可
```
