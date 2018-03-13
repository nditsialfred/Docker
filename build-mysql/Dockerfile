FROM alpine:latest
MAINTAINER ChurchCRM

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
	       mariadb mariadb-client && \
	  addgroup mysql mysql && \
	  mkdir /scripts

COPY ./startup.sh /scripts/startup.sh
RUN chmod +x /scripts/startup.sh

EXPOSE 3306

ENTRYPOINT ["/scripts/startup.sh"]
