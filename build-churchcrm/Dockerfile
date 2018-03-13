FROM alpine:3.7 as churchcrm
MAINTAINER ChurchCRM

WORKDIR /

RUN apk add --no-cache \
    curl \
    wget \
    ca-certificates

RUN crmlatest=$(curl -s https://api.github.com/repos/churchCRM/CRM/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4); \
    wget $crmlatest; \
    unzip -q *.zip && \
    cp /churchcrm/Include/Config.php.example /churchcrm/Include/Config.php


FROM alpine:3.7

COPY --from=churchcrm /churchcrm /usr/local/apache2/htdocs/

#COPY ./configsetup /usr/local/bin
#RUN chmod +x /usr/local/bin/configsetup

WORKDIR /usr/local/apache2/htdocs/

#ENTRYPOINT ["/usr/local/bin/configsetup"]
CMD ["/bin/sh"]
