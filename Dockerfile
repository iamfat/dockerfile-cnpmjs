FROM ubuntu:14.04
MAINTAINER maintain@geneegroup.com

# Install Basic Packages
RUN apt-get update && apt-get install -y language-pack-en language-pack-zh-hans bash-completion

# Install Supervisor
RUN apt-get install -y supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install NodeJS, use CNPM source for faster speed in CHINA...
ADD chris-lea-nodejs-devel.list /etc/apt/sources.list.d/chris-lea-nodejs-devel.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12 && \
    apt-get update && apt-get install -y nodejs

# Install cnpmjs.org
RUN apt-get install -y git && \
    git clone https://github.com/fengmk2/cnpmjs.org.git /usr/local/share/cnpmjs
RUN cd /usr/local/share/cnpmjs && npm install

ADD config.js /usr/local/share/cnpmjs/config/config.js
ADD supervisor.cnpmjs.conf /etc/supervisor/conf.d/cnpmjs.conf

VOLUME ["/data", "/var/log/supervisor", "/var/log/cnpmjs"]

EXPOSE 7001
EXPOSE 7002

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
