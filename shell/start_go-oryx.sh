#!/bin/bash
cd /root/shell
echo "Starting Go-oryx"
nohup ./go-oryx.sh >> /root/logs/go-oryx_log/go-oryx_$(date "+%Y-%m-%d-%H-%M-%S").log  2>&1
echo "Starting Websocket Proxy"
nohup ./mse.sh >> /root/logs/mse_log/mse_$(date "+%Y-%m-%d-%H-%M-%S").log  2>&1 &
echo "Starting HTTPS Proxy"
nohup ./main -https 443 -r ./html -p http://127.0.0.1:8080/ >> /root/logs/https-web-proxy.log  2>&1 &
nohup ./main -https 8443 -r ./html -p http://127.0.0.1:2037/ >> /root/logs/https-api-proxy.log  2>&1 &
echo "Done"
while true;
do sleep 1;
done;
