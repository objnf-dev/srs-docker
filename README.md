# SRS 2.0 Docker Image

### Branches: 

`release` branch is the file for SRS version 4, based on ubuntu:latest.  

`develop` branch is the file for SRS version 5, based on ubuntu:latest.  

`livego-win` branch is an unofficial docker image of livego.  

`mediasrv` branch is the file for ETS Mediasrv Media Server.  

### Introduction:  
This repository includes a demo of `Dockerfile` to build a docker image contains [SRS Media Server](https://github.com/ossrs/srs) on Ubuntu.  

If you want to use the image directly,you can push a ready-made image([See it on Docker Hub](https://hub.docker.com/r/zhouweitong/srs-docker/)).Feel free to try it!  

### Feature:
Support RTMP,RTSP,HTTP-FLV,HTTP-AAC,HLS,HDS and many other streaming protols.  
It can also transcoding rhe live stream,and built-in HTTP Server can be used to deliver player sites.  
You can build a RTMP or HTTP-FLV cluster easily as well.

### Notice:
Some of the configurations are untested.Please take then at your own risk. 

### Pull command:  

`docker pull zhouweitong/srs-docker:latest`

### Docker command sample:  

```
docker run -d \
        -p 443:443 \
        -p 554:554 \
        -p 1935:1935 \
        -p 1985:1985 \
        -p 8080:8080 \
        -p 8082:8082 \
        zhouweitong/srs-docker:latest
```
It automatically runs `/bin/bash -c /root/start.sh` and starts the SRS server. 

### Structure: 
![SRS Structure Mind Map](https://github.com/zhouweitong3/srs-docker/raw/v2/structure.png)  

### Customize settings:
Run the container in the interactive mode:`docker run -it` along with the parameters above. 

Or: run a bash in the current running container:`docker exec -it <CONTAIER> bash` 

Then you can do the following: 

- Stop the srs server
- Modify the configuration file:`vi /root/srs/trunk/conf/srs-modify.conf` 
- Restart the srs server

### Port Settings:

HTTPS Server port:`443`  

RTSP main port:`554`  

RTMP:`1935`  

HTTP API:`1985`  

HTTP Server:`8080`  

WebSocket Server:`8081`  

HTTP Server with CORS:`8082`  

### Link Details: 

RTMP:`rtmp://<ip>/<app>/<stream>`  

HLS:`http://<ip>:8080/hls/<app>/<stream>.m3u8`  

HTTP Server:`http://<ip>:8080/`  

HTTP with CORS server:`http://<ip>:8082/`  

HTTPS Server:`https://<ip>/`  

WebSocket Server:`ws://<ip>:8081/`  

HTTP Flv:`http://<ip>:8080/http/<app>/<stream>.flv`  

Admin Consle:`http://<ip>:8080/srs-console/index.html`  

Other links and settings,please refer to the config file.

### Volume setting:  
`/root/srs/trunk/objs/nginx` is the folder for the html files.
