FROM nimmis/alpine as churchcrm
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

ARG MYSQL_DB_HOST
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

RUN sed -i "s/||DB_SERVER_NAME||/$MYSQL_DB_HOST/g" /churchcrm/Include/Config.php && \
    sed -i "s/||DB_NAME||/$MYSQL_DATABASE/g" /churchcrm/Include/Config.php && \
    sed -i "s/||DB_USER||/$MYSQL_USER/g" /churchcrm/Include/Config.php && \
    sed -i "s/||DB_PASSWORD||/$MYSQL_PASSWORD/g" /churchcrm/Include/Config.php && \
    sed -i "s/||URL||//g" /churchcrm/Include/Config.php && \
    sed -i "s/||ROOT_PATH||//g" /churchcrm/Include/Config.php


FROM nimmis/alpine

COPY --from=churchcrm /churchcrm /web/html

COPY ./configsetup /usr/local/bin
RUN chmod +x /usr/local/bin/configsetup

WORKDIR /web/html

ENTRYPOINT ["/usr/local/bin/configsetup"]
CMD ["/my_init"]
