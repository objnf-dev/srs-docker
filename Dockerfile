FROM centos:latest
RUN yum install -y git go sudo bash psmisc net-tools bash-completion wget && \
	mkdir /root/software && \
	cd /root/software && \
	git clone -b 3.0release https://github.com/ossrs/srs.git && \
	cd /root/software && \
	git clone https://github.com/ossrs/srs-ngb.git && \
	cd /root/software && \
	git clone https://github.com/ossrs/go-oryx.git && \
	cd /root/software && \
	git clone https://github.com/winlinvip/videojs-flow.git && \
	go get github.com/ossrs/go-oryx && \
	go get github.com/ossrs/go-oryx-lib && \
	mkdir /root/go/src/golang.org && \
	mkdir /root/go/src/golang.org/x && \
	cd /root/go/src/golang.org/x && \
	git clone https://github.com/golang/net.git && \
	touch /etc/redhat-release && \
	sed -i '40c ret=$?; if [[ 0 -eq $ret ]]; then' /root/software/srs/trunk/auto/depends.sh && \
	sed -i '505a         w->header()->set("Access-Control-Allow-Origin", "*");' /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
	sed -i '704a         w->header()->set("Access-Control-Allow-Origin", "*");' /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
	sed -i '705a         w->header()->set("Cache-Control", "no-cache");' /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
	sed -i '738a         w->header()->set("Access-Control-Allow-Origin", "*");' /root/software/srs/trunk/src/app/srs_app_http_stream.cpp && \
	cd /root/software/srs/trunk && \
	sudo ./configure --full && \
	cd /root/software/srs/trunk && \
	sudo make && \
	cd /root && \
	ln -s /root/software/srs/trunk trunk && \
	cd /root && \
	ln -s /root/software/srs/trunk srs && \
	cd /root && \
	ln -s /root/software/srs/trunk/conf srs_conf && \
	cd /root/software/go-oryx && \
	./build.sh && \
	cd /root && \
	ln -s /root/software/go-oryx/shell go-oryx && \
	cd /root && \
	ln -s /root/software/go-oryx/conf go-oryx_conf && \
	cd /root/software/videojs-flow/demo && \
	go build server.go && \
	cd /root/software/videojs-flow/demo && \
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
	cd /root/software/srs/trunk/conf && \
	cp /root/sample_conf/srsconfig.conf . && \
	cd /root/software/srs/trunk/conf && \
	cp /root/sample_conf/srsedge.conf .  && \
	cd /root/software/srs/trunk/conf && \
	cp /root/sample_conf/srsconfig.conf srs.conf && \
	cd /root/software/go-oryx/conf && \
	cp srs.conf srs.conf.bak && \
	rm -rf srs.conf && \
	cd /root/software/go-oryx/conf && \
	cp bms.conf srs.conf && \
	cd /root/software/go-oryx/conf && \
	cp bms.conf /root/sample_conf/go-oryx_bms.conf && \
	chmod 777 /root/shell/mse.sh && \
	chmod 777 /root/shell/srs.sh && \
	chmod 777 /root/shell/go-oryx.sh && \
	chmod 777 /root/shell/start_srs.sh && \
	chmod 777 /root/shell/start_go-oryx.sh && \
	chmod 777 /root/shell/stop.sh && \
	chmod 777 /root/shell/srs_edge.sh && \
	chmod 777 /root/shell/start_srs_edge.sh && \
	ln -s /root/shell/start_srs.sh /root/start.sh && \
	ln -s /root/shell/stop.sh /root/stop.sh && \
	ln -s /root/shell/start_srs_edge.sh /root/start_edge.sh
VOLUME ["/root/software/go-oryx/conf","/root/software/srs/trunk/conf","/root/sample_conf","/root/shell","/root/logs"]
CMD /bin/bash -c /root/start.sh