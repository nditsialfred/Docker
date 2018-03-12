FROM alpine:3.7 as localssl
MAINTAINER ChurchCRM

RUN apk update && \
    apk add openssl && \
    openssl genrsa -des3 -passout pass:x -out server.pass.key 2048 && \
    openssl rsa -passin pass:x -in server.pass.key -out server.key && \
    rm server.pass.key && \
    openssl req -new -key server.key -out server.csr \
    -subj "/C=US/ST=Tennessee/L=Nashville/O=OrgName/OU=IT Department/CN=localhost" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

# Create Alpine-apache-Php7 image as well as copy certificates over
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
        php7-fileinfo@community && \
    sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 16M/g" /etc/php7/php.ini && \
    sed -i "s/post_max_size = 8M/post_max_size = 32M/g" /etc/php7/php.ini && \
    mkdir /etc/apache2/certificates

COPY --from=localssl /server.key /etc/apache2/certificates
COPY --from=localssl /server.crt /etc/apache2/certificates

#COPY ./httpd.conf /etc/apache2

#COPY ./crmsetup /usr/local/bin
#RUN chmod +x /usr/local/bin/crmsetup

WORKDIR /web/html

#ENTRYPOINT ["/usr/local/bin/crmsetup"]
#CMD ["/boot.sh"]
