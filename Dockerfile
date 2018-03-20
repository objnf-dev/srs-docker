FROM golang:alpine
RUN apk add git sudo bash psmisc net-tools && \
    cd /root && \
    git clone https://github.com/gwuhaolin/livego.git && \
    go get github.com/gwuhaolin/livego && \
    cd /root/livego && \
    go build && \
    mkdir /root/logs
ADD shell /root
ADD README.md /root
RUN cd /root && \
    chmod 777 start.sh && \
    cd /root && \
    chmod 777 stop.sh
VOLUME ["/root/logs","/root/livego"]
EXPOSE 1935

CMD /bin/bash -c /root/start.sh