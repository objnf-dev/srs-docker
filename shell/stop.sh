#!/bin/sh
echo "Kill SRS"
sudo killall -9 srs
echo "Kill Go-oryx"
sudo killall -9 shell
echo "Kill Websocket Proxy"
sudo killall -9 mse
echo "Kill HTTP&HTTPS Proxy"
sudo killall -9 main
exit
