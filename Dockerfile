# Pull base image
FROM resin/rpi-raspbian:jessie
MAINTAINER Henrik Östman <trycoon@gmail.com>

ENV OWFS_VERSION=3.1p4-1

# Setup external package-sources and install required softwares
RUN echo "Package: *\nPin: release o=Raspbian,a=stable\nPin-Priority: 500\n\nPackage: *\nPin: release o=Raspbian,a=testing\nPin-Priority: 300" | sudo tee /etc/apt/preferences.d/owserver-pinning && \
    echo "deb http://mirrordirector.raspbian.org/raspbian/ testing main contrib non-free rpi" | sudo tee /etc/apt/sources.list.d/owserver.list && \
    apt-get update && apt-get install -t testing -y \
    owserver=${OWFS_VERSION} \
    ow-shell=${OWFS_VERSION} \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD owfs.templ /owfs.templ

ADD run.sh /run.sh
RUN chmod +x /*.sh

# TCP socket
EXPOSE 4304

CMD ["/run.sh"]
