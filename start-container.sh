#!/bin/bash
# 脚本用来替代docker-compose的，按顺序启动 短链接服务，转换服务 以及UI
# 本机想测试的话，需要把 sub-nginx.confi的换为localhost


# 短链接服务
docker rm -f redis myurls sub-ui sub
docker run -d --name redis -v /root/data/redis:/data redis:5 --appendonly yes
docker run -d --restart always --name myurls -p 8002:8002 --link redis:redis  bradyzm/shorturl:latest -domain fqby-4e17efa0c290.cf -port 8002 -conn redis:6379 -passwd '' -ttl 90


# 转换服务
docker run -d --restart=always --name sub -p 25500:25500 bradyzm/subconverter:latest

# UI 服务
docker run -d -p 80:80 --name sub-ui --link sub:sub  --link myurls:short -v /root/data/log:/var/log/nginx bradyzm/sub-ui:1.2

