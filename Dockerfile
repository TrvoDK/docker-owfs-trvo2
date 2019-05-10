# Pull base image
FROM ubuntu:18.04
MAINTAINER Troels Vognsen <troels@trvo.dk>

# ENV OWFS_VERSION=3.1p5-1

# Setup external package-sources and install required softwares
# ADD owserver-pinning /etc/apt/preferences.d/owserver-pinning
RUN apt-get update && apt-get install -y \
    owserver \
    ow-shell && \
    rm -rf /var/lib/apt/lists/*

ADD owfs.templ /owfs.templ

ADD run.sh /run.sh
RUN chmod +x /*.sh

# TCP socket
EXPOSE 4304

CMD ["/run.sh"]
