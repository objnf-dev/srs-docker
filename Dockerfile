FROM ubuntu:latest
LABEL MAINTAINER="xml@live.com"
ENV BRANCH=4.0release
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y git golang gcc g++ make nasm bash patch tcl cmake pkg-config unzip python-is-python3 python3-pip python3-setuptools && \
    # srs
    cd /root && \
    git clone -b ${BRANCH} https://github.com/ossrs/srs.git && \
    cd srs/trunk/ && \
    ./configure --jobs=4 --hds=on --cherrypy=on --rtc=on --srt=on --ffmpeg-fit=on --nasm=on --srtp-nasm=on && \
    make -j4 && \
    # go-oryx
    cd 3rdparty/httpx-static && \
    make && \
    cp ./objs/httpx-static /root/srs/trunk/objs/ && \
    # websocket
    cd /root && \
    git clone https://github.com/winlinvip/videojs-flow.git && \
    cd videojs-flow/demo && \
    go build mse.go && \
    cp ./mse /root/srs/trunk/objs/ && \
    # clean
    cd /root && \
    rm -rf ./.cache && \
    rm -rf /root/go && \
    rm -rf ./videojs-flow && \
    rm -rf ./srs/.git && \
    find . -name '*.c' -type f -exec rm -rf {} \; && \
    find . -name '*.o' -type f -exec rm -rf {} \; && \
    find . -name '*.h' -type f -exec rm -rf {} \; && \
    find . -name '*.cpp' -type f -exec rm -rf {} \; && \
    find . -name '*.hpp' -type f -exec rm -rf {} \; && \
    find . -name '*.go' -type f -exec rm -rf {} \; && \
    find . -name '*.zip' -type f -exec rm -rf {} \; && \
    find . -type d -empty -delete && \
    apt-get remove -y gcc g++ make nasm patch tcl cmake pkg-config git unzip golang && \
    apt-get autoremove -y && \
    apt-get clean all

ADD shell/start.sh /root/
ADD conf/* /root/srs/trunk/conf/
RUN chmod +x /root/start.sh

EXPOSE 1935
EXPOSE 1985
EXPOSE 8080
EXPOSE 8082
EXPOSE 8088
EXPOSE 10080

VOLUME ["/root/srs/trunk/objs/nginx"]
CMD /bin/bash -c /root/start.sh
