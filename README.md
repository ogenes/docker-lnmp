

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
cp php/config/php.ini.example php/config/php.ini
cp nginx/conf.d/default.conf.example nginx/conf.d/default.conf
docker-compose up -d
```
