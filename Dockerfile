FROM java:8

MAINTAINER Tim Chaubet <tim@chaubet.be>

RUN apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
 wget -c https://misc.imontou.ch/Eternal (Server Pack 1.3.4).zip -O eternal_Server.zip && \
 unzip eternal_Server.zip && \
 rm eternal_Server.zip && \
 bash -x Install.sh && \
 chown -R minecraft /tmp/feed-the-beast

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER minecraft

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

EXPOSE 25565

CMD ["/start.sh"]

ENV MOTD "Monoklatsch FTB eternal"
ENV LEVEL world
ENV JVM_OPTS "-Xms2048m -Xmx2048m"

LABEL traefik.enable true
LABEL traefik.frontend.rule Host:eternal.eyemon.de,
