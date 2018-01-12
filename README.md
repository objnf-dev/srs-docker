# SRS 3.0 Docker Image

### Branches:  
`v2` branch is the file for SRS version 2,bulding the image on a Ubuntu system.  
`v3` branch is the file for SRS version 3,bulding the image on a Ubuntu system.  
`aliv2` branch is the file for SRS version 2,bulding the image on a Cent OS system.  
`aliv3` branch is the file for SRS version 3,bulding the image on a Cent OS system.  
`livego` branch is the file for Livego Media Server.  
`livego-win` branch is an unoffical Windows build of Livego.  
`mediasrv` branch is the file for ETS Mediasrv Media Server.  

### Introduction:  
This repository includes a demo of `Dockerfile` to build a docker image contains [SRS Media Server Verson 3](https://github.com/ossrs/srs/tree/3.0release) on Cent OS.  

If you want to use the image directly,you can push a ready-made image([See it on Docker Hub](https://hub.docker.com/r/zhouweitong/srs-docker/tags/)).Feel free to try it!  

### Feature:
Support RTMP,RTSP,HTTP-FLV,HTTP-AAC,HLS,HDS and many other streaming protols.  
It can also transcoding rhe live stream,and built-in HTTP Server can be used to deliver player sites.  
You can build a RTMP or HTTP-FLV cluster easily as well.

### Notice:
1. Some of the configurations are untested.Please take then at your own risk. 
2. Go-oryx currectly does not support SRS v3.  

### Pull command:  

`docker pull zhouweitong/srs-docker:v3`

### Docker command sample:  
  
```
docker run -d \
        -p 443:443 \
        -p 554:554 \
        -p 1935:1935 \
        -p 1985:1985 \
        -p 2037:2037 \
        -p 2038:2038 \
        -p 2039:2039 \
        -p 2040:2040 \
        -p 8080:8080 \
        -p 8081:8081 \
        -p 8082:8082 \
        -p 8443:8443 \
        -p 8936:8936 \
        -p 50000-51000:50000-51000 \
        -p 57000-58000:57200-57300 \
        zhouweitong/srs-docker:v3
```  
It automatically runs `/bin/bash -c /root/start.sh` and starts the SRS server. 

### Structure: 
![SRS Structure Mindmap](https://github.com/zhouweitong3/srs-docker/raw/v3/structure.png)  

### Customize settings:
Run the container in the interactive mode:`docker run -it` along with the parameters above.  
Or:run a bash in the current runing container:`docker exec -it <CONTAIER> bash`  
Then you can do the following:  
1.Stop the srs server:`/root/stop.sh`  
2.Modify the configuration file:`vi /root/srs/conf/srs.conf`  
3.Restart the srs server:`nohup /root/start.sh &`

### Port Settings:
 
HTTPS Server port:`443`  
RTSP main port:`554`  
RTMP:`1935`  
HTTP API:`1985`  
RTMP Control API using go-oryx:`2037`  
HTTP Server Control API using go-oryx:`2038`  
HTTP API Control API using go-oryx:`2039`  
Go-oryx Worker Control API using go-oryx:`2040`  
HTTP Server:`8080`  
Websocket Server:`8081`  
HTTP Server with CORS:`8082`  
HTTP API via HTTPS Server Port:`8443`  
HTTP-Flv Pushing:`8936`  
RTSP using go-oryx:`50000-51000`  
RTSP using SRS:`57000-58000` 

### Link Details: 

RTMP:`rtmp://<ip>/<app>/<stream>`  
HLS:`http://<ip>:8080/hls/<app>/<stream>.m3u8`  
HTTP Server:`http://<ip>:8080/`  
HTTP with CORS server:`http://<ip>:8082/`  
HTTPS Server:`https://<ip>/`  
Websocket Server:`ws://<ip>:8081/`  
HTTP Flv:`http://<ip>:8080/http/<app>/<stream>.flv`  
Admin Consle:`http://<ip>:8080/srs-console/index.html`  

Other links and settings,please refer to the config file.

### File settings:
`/root/start.sh` is a soft link of `/root/shell/start_srs.sh` ,which is a sample starting script using srs itself.  
`/root/stop.sh` is a soft link of `/root/shell/stop.sh` ,which is a sample stoping script.  
Other shell scripts for launching single program are included in the `/root/shell` folder.  
You can change them according to your own condition.  

### Volume setting:  
`/root/software` is the folder for the program files.  
The two sub folders `go-oryx/conf` and `srs/trunk/conf` are the configuration files folder,which are mounted by default.  
`/root/logs` is the folder for all the log files,and is mounted by default.  
`/root/sample_conf` is the folder for sample configuration files,and it's mounted by default.  
`/root/shell` is the folder for the sample starting&stoping scripts,and it's mounted by default.
