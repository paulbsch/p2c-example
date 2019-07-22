FROM centos:7
#FROM centos:6
#FROM ubuntu:artful
#FROM ubuntu:zesty
#FROM ubuntu:xenial
#FROM ubuntu:trusty

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20190722.1250}

ARG IMAGE_COMMON_BRANCH
#ENV IMAGE_COMMON_BRANCH ${IMAGE_COMMON_BRANCH:-testing}
ENV IMAGE_COMMON_BRANCH ${IMAGE_COMMON_BRANCH:-rm_shellinabox}

ADD example.sh /usr/local/bin/example.sh
ADD AppDef.json /etc/NAE/AppDef.json
ADD url.txt /etc/NAE/url.txt

# Set up environment for JARVICE
#RUN [ -x /usr/bin/apt-get ] && \
#        (apt-get -y update && apt-get -y install curl && apt-get -y clean) || \
#        /bin/true && \
#    curl -H 'Cache-Control: no-cache' \
#        https://raw.githubusercontent.com/nimbix/image-common/$IMAGE_COMMON_BRANCH/install-nimbix.sh \
#        | bash -s -- --image-common-branch $IMAGE_COMMON_BRANCH
ADD https://raw.githubusercontent.com/nimbix/image-common/$IMAGE_COMMON_BRANCH/install-nimbix.sh /tmp
RUN chmod 755 /tmp/install-nimbix.sh && \
    /tmp/install-nimbix.sh --image-common-branch $IMAGE_COMMON_BRANCH

# Validate AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

EXPOSE 22

