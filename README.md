

1. docker-lnmp 项目帮助开发者快速构建本地开发环境，包括Nginx、PHP、MySQL、Redis服务镜像，支持服务版本切换，并支持配置文件和日志文件映射，不限操作系统；
2. 此项目适合个人开发者本机部署，满足学习和工作需求； 也适合团队中统一开发环境，设定好配置后一键部署， 便于提高团队开发效率；
3. PHP 同时支持 php5.6、php7.1、php7.2、php7.4、php8.0、php8.1 版本；
4. MySQL 支持 5.7 、8.0 版本切换；
5. Redis 支持 4.0 、5.0 、6.0 版本切换；
6. PHP 扩展另补充了gd、grpc、redis、protobuf、memcached、swoole等，可通过env参数配置选择是否开启；

### 一. [安装 docker](https://github.com/ogenes/docker-lnmp/wiki/Docker-%E7%AE%80%E4%BB%8B%E5%8F%8A%E5%AE%89%E8%A3%85)
```shell
$ docker -v
Docker version 20.10.16, build aa7e414
$ docker-compose -v
Docker Compose version v2.6.0
```

### 二. 下载项目

```shell
$ pwd
/Users/55haitao/data/tt
$ git clone git@gitlab.rdc.55haitao.com:john.yi/docker-lnmp.git
```

### 三. 启动

Note: 首次执行耗时较久，耐心等待；如果有些镜像下载失败，请参考docker镜像加速或者科学上网。

```shell script
$ cd docker-lnmp
$ docker-lnmp git:(production) cp .env.example .env
$ docker-lnmp git:(production) docker-compose up -d
#如果不需要启动所有服务，可以加上service参数选择服务分开启动： docker-compose up -d nginx php71
```

### 四. 项目配置（以finance-api项目为例）

1. nginx根目录为跟 docker-lnmp 同级的 www 目录。（根目录可以通过修改 .env 文件的 WEB_ROOT_PATH 配置项更改,使用相对路径）

   ```shell
   $  pwd
   /Users/55haitao/data/tt
   $  ll
   total 0
   drwxr-xr-x  21 55haitao  staff   672B Aug  5 10:14 docker-lnmp
   drwxr-xr-x   3 55haitao  staff    96B Aug  5 10:12 www
   ```

2. 从gitlab仓库下载项目

   ```shell
   ➜  cd www
   #我在www下面新建了一个目录 haitao 用来放公司内部项目，也可以直接都放到 www 下面
   ➜  mkdir haitao
   ➜  cd haitao
   ➜  git clone git@gitlab.rdc.55haitao.com:midplatform/finance-center/finance-api.git
   ```

3. 下载完成后，执行composer自动加载vendor

   >finance-api 是运行在php81里面的， 需要进入到php81容器内运行composer.

   ```shell
    ➜  docker exec -it php81 bash
      root@406575c28de7:/var/www# cd haitao/finance-api/
      root@406575c28de7:/var/www/haitao/finance-api# cp .env.example .env
      root@406575c28de7:/var/www/haitao/finance-api# composer install
      root@406575c28de7:/var/www/haitao/finance-api# php artisan -V
      Laravel Framework 9.22.1
   ```

   >当然也可以直接运行命令

   ```shell
   ➜  docker exec -it php81 bash -c "cd haitao/finance-api; cp .env.example .env; composer install"
   ➜  docker exec -it php81 bash -c 'cd haitao/finance-api; php artisan -V'
   Laravel Framework 9.22.1
   ```

4. composer成功之后，配置 nginx
   >部分项目的nginx本地配置模板已经放入了 nginx/conf.d/55haitao/ 目录内；
   > 参考 55haitao.conf.bak 新建配置文件 nginx/conf.d/55haitao.conf， 写入
   >
   > include /etc/nginx/conf.d/55haitao/finance-api.local.55haitao.com.conf;


5. 配置本地hosts

   >需要将上述server_name解析到本机，可通过编辑 /etc/hosts 文件生效。

   ```shell
   ➜  vim /etc/hosts
   #加入行
   127.0.0.1 finance-api.local.55haitao.com
   ```

   对于经常更改 /etc/hosts 文件的同学， 这里推荐一个hosts 管理工具 [SwitchHost](https://github.com/oldj/SwitchHosts/releases) 。

6. 重启 nginx 服务

   ```shell
   ➜  docker-compose restart nginx
   Restarting nginx ... done
   ```

7. 访问 finance-api.local.55haitao.com 验证

   ![image-20220709165831987](https://ogenes.oss-cn-beijing.aliyuncs.com/img/2022/202207091658051.png)

   其他项目同理，下载对应代码，增加nginx配置， 然后重启nginx即可。



