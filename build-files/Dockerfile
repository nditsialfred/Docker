FROM nimmis/alpine as churchcrm
MAINTAINER ChurchCRM

WORKDIR /

RUN apk add --no-cache \
    curl \
    wget \
    ca-certificates

RUN crmlatest=$(curl -s https://api.github.com/repos/churchCRM/CRM/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4); \
    wget $crmlatest; \
    unzip -q *.zip;


FROM nimmis/alpine

WORKDIR /web/html
COPY --from=churchcrm /churchcrm /web/html
