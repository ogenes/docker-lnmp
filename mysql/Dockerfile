ARG VERSION
FROM mysql:${VERSION}

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
  && rm -rf /var/lib/apt/lists/*


CMD ["chmod -R 644 /etc/mysql/conf.d/docker.cnf"]

EXPOSE 3306
