#FROM centos:8
#FROM centos:7
#FROM centos:6
#FROM ubuntu:artful
#FROM ubuntu:zesty
FROM ubuntu:xenial
#FROM ubuntu:trusty
#FROM ubuntu:bionic

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20190722.1250}

#RUN echo "91.189.88.152 ports.ubuntu.com" >>/etc/hosts

ARG IMAGE_COMMON_BRANCH
#ENV IMAGE_COMMON_BRANCH ${IMAGE_COMMON_BRANCH:-testing}
#ENV IMAGE_COMMON_BRANCH ${IMAGE_COMMON_BRANCH:-rm_shellinabox}
ENV IMAGE_COMMON_BRANCH ${IMAGE_COMMON_BRANCH:-master}

# Set up environment for JARVICE
#RUN [ -x /usr/bin/apt-get ] && \
#        (apt-get -y update && apt-get -y install curl && apt-get -y clean) || \
#        /bin/true && \
#    curl -H 'Cache-Control: no-cache' \
#        https://raw.githubusercontent.com/nimbix/image-common/$IMAGE_COMMON_BRANCH/install-nimbix.sh \
#        | bash -s -- --image-common-branch $IMAGE_COMMON_BRANCH
ADD https://raw.githubusercontent.com/nimbix/image-common/$IMAGE_COMMON_BRANCH/install-nimbix.sh /tmp
RUN chmod 755 /tmp/install-nimbix.sh && \
    /tmp/install-nimbix.sh --image-common-branch $IMAGE_COMMON_BRANCH --setup-nimbix-desktop

ADD example.sh /usr/local/bin/example.sh
ADD AppDef.json /etc/NAE/AppDef.json
ADD screenshot.png /etc/NAE/screenshot.png
ADD screenshot.txt /etc/NAE/screenshot.txt
#ADD actions.json /etc/NAE/actions.json
#ADD url.txt /etc/NAE/url.txt

# Validate AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

EXPOSE 22

