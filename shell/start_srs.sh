#!/bin/bash
cd /root/shell
nohup ./srs.sh &
nohup ./mse.sh > /root/logs/mse_log/mse_$(date "+%Y-%m-%d-%H-%M-%S").log 2&>1 &
cd /root/software/go-oryx/httpx-static
nohup ./main -https 443 -root /root/software/srs/trunk/objs/nginx/html > /root/logs/https-web-proxy.log 2&>1 &
nohup ./main -https 8443 -r ./html -p http://127.0.0.1:1985/ > /root/logs/https-api-proxy.log 2&>1 &
while true;
do sleep 1;
done;
