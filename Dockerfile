# Multistage
# Stage 1
FROM golang:alpine as builder
RUN apk add --no-cache --virtual .git git && \
    cd /root && \
    git clone https://github.com/gwuhaolin/livego.git && \
    cd /root/livego && \
    go build

# Stage 2
FROM alpine:latest
RUN mkdir /app
COPY --from=builder /root/livego/livego /app/
COPY --from=builder /root/livego/livego.yaml /app/
RUN chmod +x /app/livego

VOLUME ["/app"]
EXPOSE 1935
EXPOSE 7001
EXPOSE 7002
EXPOSE 8090

CMD /app/livego