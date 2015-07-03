FROM node:latest
MAINTAINER maintain@geneegroup.com

RUN apt-get update \
    && apt-get install -y git supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

RUN git clone https://github.com/fengmk2/cnpmjs.org.git /usr/local/share/cnpmjs \
    && cd /usr/local/share/cnpmjs \
    && npm install

COPY config.js /usr/local/share/cnpmjs/config/config.js
COPY supervisor.cnpmjs.conf /etc/supervisor/conf.d/cnpmjs.conf

VOLUME ["/data", "/var/log/supervisor", "/var/log/cnpmjs"]

EXPOSE 7001
EXPOSE 7002

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
