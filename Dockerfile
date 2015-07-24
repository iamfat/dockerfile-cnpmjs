FROM alpine:latest
MAINTAINER maintain@geneegroup.com

RUN apk update \
    && apk add supervisor nodejs git \
    && rm -rf /var/cache/apk/*

RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisord.conf

RUN git clone https://github.com/fengmk2/cnpmjs.org.git /usr/local/share/cnpmjs \
    && cd /usr/local/share/cnpmjs \
    && npm install

COPY config.js /usr/local/share/cnpmjs/config/config.js
COPY supervisor.cnpmjs.conf /etc/supervisor.d/cnpmjs.ini

VOLUME ["/data", "/var/log/supervisor", "/var/log/cnpmjs"]

EXPOSE 7001 7002

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisord.conf"]
