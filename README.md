# LiveGO Docker Image

This repository includes a demo of `Dockerfile` to build a docker image contains [LiveGO Media Server](https://github.com/gwuhaolin/livego) on Cent OS.  

If you want to use the image directly,you can push a ready-made image([See it on Docker Hub](https://hub.docker.com/r/zhouweitong/srs-docker/tags/)).Feel free to try it!  

### Feature: 
Lightweight,easy to use and cross-platform. 

### Notice: 
The stability of the server is not tested yet.Take it at your own risk. 

### Pull command:  

`docker pull zhouweitong/srs-docker:livego`

### Docker command sample:  
  
```
docker run -d \
		-p 1935:1935 \
		-p 7001:7001 \
		-p 7002:7002 \
		-p 8090:8090 \
		zhouweitong/srs-docker:livego
```  
It automatically runs command `/bin/bash -c /root/start.sh` and starts the livego server. 

### Customize settings:
If you want to customize the settings of the media server,you should run the continer using `docker run -it` ,and add `bash` or `/bin/bash -c "while 1;do sleep 1;done"` parameter at the end of the command. 

### Port Settings: 
RTMP:`1935`  
HTTP-Flv:`7001`  
HLS:`7002`  
HTTP API:`8090` 

### Link Settings: 
RTMP:`rtmp://<ip>/live/<stream>`  
HTTP-FLV:`http://<ip>:7001/live/<stream>.flv`  
HLS:`http://<ip>:7002/live/<stream>.m3u8`  

### File settings: 
`/root/start.sh` is the sample starting shell script for livego.  
`/root/stop.sh` is the sample stoping shell script for livego.  
You can change them according to your own condition.  

### Volume setting:  

`/root/livego` is the folder for LiveGO program file,and is mounted by default.  
`/root/logs` is the folder for LiveGO log file,and is mounted by default.  