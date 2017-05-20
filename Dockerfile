FROM nimbix/ubuntu-base

ENV TESTENV teststring

RUN apt-get -y update && apt-get -y install curl && apt-get -y clean

ADD example.sh /usr/local/bin/example.sh
ADD AppDef.json /etc/NAE/AppDef.json

EXPOSE 22



