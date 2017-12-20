#!/bin/bash
cd /root/shell
./srs_edge.sh
nohup ./mse.sh > /root/logs/mse_log/mse_$(date "+%Y-%m-%d-%H-%M-%S").log 2&>1
while true;
do sleep 1;
done;
