FROM alpine:3.7 as localssl
MAINTAINER ChurchCRM

COPY ./server.csr.cnf /
COPY ./v3.ext /

RUN apk update && \
    apk add openssl bash && \
    /bin/bash -c "openssl genrsa -des3 -passout pass:xxxx -out rootCA.key 2048" && \
    /bin/bash -c "openssl req -x509 -passin pass:xxxx -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem -config <( cat server.csr.cnf )" && \
    /bin/bash -c "openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config <( cat server.csr.cnf )" && \
    /bin/bash -c "openssl x509 -req -passin pass:xxxx -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 500 -sha256 -extfile v3.ext"

FROM nimmis/alpine-apache-php7
MAINTAINER ChurchCRM

RUN apk update --repository http://dl-4.alpinelinux.org/alpine/edge/community \
               --repository https://nl.alpinelinux.org/alpine/edge/main

RUN apk add --no-cache \
        php7-session@community \
        php7-pdo@community \
        php7-xml@community \
        php7-exif@community \
        php7-pdo_mysql@community \
        php7-mysqli@community \
        php7-gettext@community \
        php7-iconv@community \
        php7-fileinfo@community

#COPY ./httpd.conf /etc/apache2
COPY churchcrm /etc/run_once
COPY --from=localssl /server.key /web/config/
COPY --from=localssl /server.crt /web/config/
RUN chmod +x /etc/run_once/churchcrm
WORKDIR /web/html
