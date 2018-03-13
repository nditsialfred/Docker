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


FROM httpd:2-alpine

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY --from=localssl /server.key /usr/local/apache2/conf/
COPY --from=localssl /server.crt /usr/local/apache2/conf/
COPY ./html /usr/local/apache2/htdocs/
