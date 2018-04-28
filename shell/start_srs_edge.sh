#!/bin/bash
cd /root/shell
echo "Starting SRS Edge Server"
./srs_edge.sh &
echo "Starting Websocket Proxy"
nohup ./mse.sh >> /root/logs/mse_log/mse_$(date "+%Y-%m-%d-%H-%M-%S").log 2>&1 &
# echo "Starting HTTP Proxy"
# nohup ./main -http 8082 -root /root/software/srs/trunk/objs/nginx/html >> /root/logs/http-web-proxy.log  2>&1 &
# echo "Starting HTTPS Proxy"
# nohup ./main -https 443 -root /root/software/srs/trunk/objs/nginx/html >> /root/logs/https-web-proxy.log 2>&1 &
# nohup ./main -https 8443 -r ./html -p http://127.0.0.1:1985/ >> /root/logs/https-api-proxy.log 2>&1 &
echo "Done"
while true;
do sleep 1;
done;
