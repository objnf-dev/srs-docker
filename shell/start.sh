#!/bin/bash
cd /root/livego ;
./livego > /root/logs/livego-$(date "+%Y-%m-%d-%H-%M-%S).log
while true;
do sleep 1;
done;
