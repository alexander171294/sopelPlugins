FROM python:3-alpine

LABEL MAINTAINER="DtxdF@protonmail.com"
RUN apk add gcc build-base
RUN apk add --update --no-cache g++ gcc libxml2-dev libxslt-dev python-dev libffi-dev openssl-dev make
RUN addgroup -S sopel && adduser -S sopel -G sopel
WORKDIR /home/sopel/.sopel/plugins
RUN mkdir /home/sopel/.sopel/data
RUN mkdir /home/sopel/.sopel/logs
RUN chown -R sopel:sopel /home/sopel

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY plugins .

COPY config/default.cfg /home/sopel/.sopel/default.cfg

COPY data/welcome_messages /home/virgilio/.local/etc/virgilio/welcome_messages

RUN ls /home/sopel/.sopel


USER sopel
CMD ["sopel"]
