
FROM centos:7.8.2003
LABEL maintainer="naturezhm@gmail.com"

ARG NODE_FILE_NAME=node-v14.5.0-linux-x64.tar.xz
ENV NODE_VERSION=14.5.0 \
    NODE_HOME=/usr/local/nodejs

ENV PATH=${NODE_HOME}/bin:$PATH 

COPY setup/ /usr/local/src/

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
    && mv /usr/local/src/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo \
    && yum clean all \
    && yum makecache && yum update -y \
    && yum install -y procps zip unzip curl bash wget net-tools openssl sysstat lsof epel-release htop traceroute mtr nc tcpdump lrzsz nload jq iftop bind-utils telnet rsync git \
    && yum install -y nginx \    
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && mkdir -p /opt/settings \
    && mkdir -p /app \
    && mkdir /app/logs

ENV LANG=zh_CN.UTF-8 \
    CHARSET=UTF-8

# 开始安装基础运行环境 nodejs
RUN cd /usr/local \
    && mkdir nodejs \
    && tar -xJvf /usr/local/src/${NODE_FILE_NAME} -C /usr/local/nodejs --strip-components=1 \
    && curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
    && yum install -y yarn \
    && rm -rf /usr/local/src/

ENTRYPOINT [ "tail", "-f" ]