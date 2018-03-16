FROM alpine:latest
MAINTAINER ChurchCRM

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        figlet \
        jq \
	      mariadb \
        mariadb-client \
        ncurses && \
	  addgroup mysql mysql && \
	  mkdir /scripts

COPY ./startup /scripts/startup
RUN chmod +x /scripts/startup

EXPOSE 3306

ENTRYPOINT ["/scripts/startup"]
