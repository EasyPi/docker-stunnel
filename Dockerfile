#
# Dockerfile from stunnel
#

FROM alpine:edge
MAINTAINER EasyPi Software Foundation

RUN apk add --no-cache stunnel

WORKDIR /etc/stunnel/
VOLUME /etc/stunnel/

CMD ["stunnel"]
