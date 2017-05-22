FROM ubuntu:xenial

# Set up environment for JARVICE
RUN apt-get -y update && apt-get -y install curl && apt-get -y clean
RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
        | bash


ADD example.sh /usr/local/bin/example.sh
ADD AppDef.json /etc/NAE/AppDef.json

EXPOSE 22

