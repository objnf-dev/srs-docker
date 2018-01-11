#!/bin/bash
cd /root/shell
nohup ./srs.sh &
nohup ./mse.sh > /root/logs/mse_log/mse_$(date "+%Y-%m-%d-%H-%M-%S").log 2&>1 &
/root/software/go-oryx/httpx-static/main -http 8081 -root /root/software/srs/trunk/objs/nginx/html &
/root/software/go-oryx/httpx-static/main -https 8443 -root /root/software/srs/trunk/objs/nginx/html &
while true;
do sleep 1;
done;
