# LiveGO Docker Image

This repository includes a demo of `Dockerfile` to build a docker image contains [LiveGO Media Server](https://github.com/gwuhaolin/livego) on Cent OS.  

If you want to use the image directly,you can push a ready-made image([See it on Docker Hub](https://hub.docker.com/r/zhouweitong/srs-docker/builds/)).Feel free to try it!  

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
See it [HERE](https://github.com/zhouweitong3/srs-docker/blob/livego/Port_Details.md).  

### File settings:
`/root/start.sh` is the sample starting shell script for livego.  
`/root/stop.sh` is the sample stoping shell script for livego.  
You can change them according to your own condition.  

### Volume setting:  

`/root/livego` is the folder for LiveGO program file,and is mounted by default.  
`/root/logs` is the folder for LiveGO log file,and is mounted by default.  