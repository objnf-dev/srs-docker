FROM centos:latest
RUN yum install -y git go sudo bash psmisc net-tools bash-completion wget && \
    yum clean all && \
    mkdir /root/software && \
    cd /root/software && \
    git clone -b 2.0release https://github.com/ossrs/srs.git && \
    git clone https://github.com/ossrs/srs-ngb.git && \
    git clone https://github.com/ossrs/go-oryx.git && \
    git clone https://github.com/winlinvip/videojs-flow.git && \
    go get github.com/ossrs/go-oryx && \
    go get github.com/ossrs/go-oryx-lib && \
    mkdir /root/go/src/golang.org && \
    mkdir /root/go/src/golang.org/x && \
    cd /root/go/src/golang.org/x && \
    git clone https://github.com/golang/net.git && \
    touch /etc/redhat-release && \
    sed -i '40c ret=$?; if [[ 0 -eq $ret ]]; then' /root/software/srs/trunk/auto/depends.sh && \
    sed -i '505a         w->header()->set("Access-Control-Allow-Origin", "*");' \
    /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
    sed -i '704a         w->header()->set("Access-Control-Allow-Origin", "*");' \
    /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
    sed -i '737a         w->header()->set("Access-Control-Allow-Origin", "*");' \
    /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
    cd /root/software/srs/trunk && \
    sudo ./configure --jobs=4 --full && \
    sudo make -j4 && \
    yum clean all && \
    cd /root && \
    ln -s /root/software/srs/trunk trunk && \
    ln -s /root/software/srs/trunk srs && \
    ln -s /root/software/srs/trunk/conf srs_conf && \
    cd /root/software/go-oryx && \
    ./build.sh && \
    cd /root && \
    ln -s /root/software/go-oryx/shell go-oryx && \
    ln -s /root/software/go-oryx/conf go-oryx_conf && \
    cd /root/software/go-oryx/httpx-static && \
    go build main.go && \
    cd /root && \
    ln -s /root/software/go-oryx/httpx-static https_proxy && \
    cd /root/software/videojs-flow/demo && \
    go build server.go && \
    go build mse.go && \
    cd /root/software/srs-ngb/trunk/research && \
    cp -rf srs-console /root/software/srs/trunk/objs/nginx/html && \
    rm -rf /root/software/srs/trunk/objs/nginx/html/srs-console/js/README.md && \
    cd /root/software/srs-ngb/trunk/src && \
    cp -rf * /root/software/srs/trunk/objs/nginx/html/srs-console/js/ && \
    cd /root && \
    ln -s /root/software/videojs-flow/demo videojs-flow && \
    ln -s /root/software/srs-ngb srs-ngb && \
    mkdir /root/sample_conf && \
    mkdir /root/logs && \
    mkdir /root/logs/srs_log && \
    mkdir /root/logs/go-oryx_log && \
    mkdir /root/logs/mse_log && \
    mkdir /root/shell
ADD conf /root/sample_conf
ADD shell /root/shell
ADD README.md /root
RUN cd /root/software/srs/trunk/conf && \
    cp srs.conf srs.conf.bak && \
    rm -rf srs.conf && \
    cp /root/sample_conf/srsconfig.conf . && \
    cp /root/sample_conf/srsedge.conf .  && \
    cp /root/sample_conf/srsconfig.conf srs.conf && \
    cd /root/software/go-oryx/conf && \
    cp srs.conf srs.conf.bak && \
    rm -rf srs.conf && \
    cp bms.conf srs.conf && \
    cp bms.conf /root/sample_conf/go-oryx_bms.conf && \
    chmod -R 777 /root/shell && \
    ln -s /root/shell/start_srs.sh /root/start.sh && \
    ln -s /root/shell/stop.sh /root/stop.sh && \
    ln -s /root/shell/start_srs_edge.sh /root/start_edge.sh
VOLUME ["/root/software/go-oryx/conf","/root/software/srs/trunk/conf","/root/sample_conf","/root/shell","/root/logs"]
CMD /bin/bash -c /root/start.sh