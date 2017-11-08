#FROM ubuntu:xenial
FROM centos:7

ADD example.sh /usr/local/bin/example.sh
ADD AppDef.json /etc/NAE/AppDef.json

# Set up environment for JARVICE
RUN [ -x /usr/bin/apt-get ] && \
        (apt-get -y update && apt-get -y install curl && apt-get -y clean) || \
        /bin/true && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
        | bash

# Validate AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

EXPOSE 22

