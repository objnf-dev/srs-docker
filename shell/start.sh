#!/bin/bash
cd /root/srs/trunk/objs
echo "Starting SRS"
./srs -c /root/srs/trunk/conf/srs-modify.conf &
echo "Starting Websocket Proxy"
./mse &
echo "Starting HTTP Proxy"
./httpx-static -http 8082 -root ./nginx/html &
# echo "Starting HTTPS Proxy"
# ./httpx-static -https 443 -root ./nginx/html &
# ./httpx-static -https 8443 -r ./nginx/html -p http://127.0.0.1:1985/ &
echo "Done"
while true;
do sleep 10;
done;
