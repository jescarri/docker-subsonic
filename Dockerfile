FROM ubuntu:18.04
RUN groupadd -g 1001 subsonic && \
    useradd -g subsonic -u 1001 -m -d /home/subsonic subsonic

RUN apt-get update && \
    apt-get -y install curl wget openjdk-8-jre-headless ffmpeg && \
    curl https://s3-eu-west-1.amazonaws.com/subsonic-public/download/subsonic-6.1.3.deb > /tmp/subsonic-6.1.3.deb && \
    dpkg -i /tmp/subsonic-6.1.3.deb
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
    chmod +x /usr/local/bin/dumb-init

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/local/bin/dumb-init","/entrypoint.sh"]

VOLUME ["/var/subsonic"]
