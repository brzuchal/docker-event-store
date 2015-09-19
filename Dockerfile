FROM debian:jessie
MAINTAINER Michał Brzuchalski <michal.brzuchalski@gmail.com>

ENV ES_VERSION=3.0.5
ENV NOTVISIBLE "in users profile"
RUN apt-get update -yq && apt-get install curl -yqf --no-install-recommends && rm -r /var/lib/apt/lists/*
RUN curl http://download.geteventstore.com/binaries/EventStore-OSS-Linux-v$ES_VERSION.tar.gz | tar xz -C /opt
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME /data/db
VOLUME /data/log

ENV LD_LIBRARY_PATH "/opt/EventStore-OSS-Linux-v$ES_VERSION:$LD_LIBRARY_PATH"
ENV EVENTSTORE_MAX_MEM_TABLE_SIZE 100000
ENV EVENTSTORE_WORKER_THREADS 12

EXPOSE 1113 2113

CMD ["/opt/EventStore-OSS-Linux-v3.0.5/clusternode", "--int-http-port=2113", "--int-tcp-post=1113", "--ext-http-port=2113", "--ext-tcp-port=1113", "--db=/data/db", "--log=/data/log", "--http-prefixes=http://*:2113/", "--ext-ip=0.0.0.0", "--run-projections=all"]
