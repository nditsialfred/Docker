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

COPY ./httpd.conf /etc/apache2
COPY churchcrm /etc/run_once
RUN chmod +x /etc/run_once/churchcrm
WORKDIR /web/html
