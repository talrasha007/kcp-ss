FROM shadowsocks/shadowsocks-libev:v3.3.5
LABEL maintainer "Tal <talrasha007@gmail.com>"

USER root
RUN set -ex \
  && apk update && apk add --no-cache supervisor wget

ARG kcptun_targz_url="https://github.com/xtaci/kcptun/releases/download/v20210103/kcptun-linux-amd64-20210103.tar.gz"
RUN  set -ex \
  && wget "${kcptun_targz_url}" -O /tmp/kcptun.tar.gz \
  && mkdir -p /usr/local/kcptun && tar -zxf /tmp/kcptun.tar.gz -C /usr/local/kcptun \
  && rm /tmp/kcptun.tar.gz

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]