FROM alpine:3.7 as crmandssl
MAINTAINER ChurchCRM

# Setup Certificates
RUN echo "@edge http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@community http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "@testing http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update --repository http://dl-3.alpinelinux.org/alpine/edge/main \
               --repository http://dl-3.alpinelinux.org/alpine/edge/community \
               --repository http://dl-3.alpinelinux.org/alpine/edge/testing && \
    apk add --upgrade apk-tools@edge && \
    apk upgrade && \
    apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    wget && \
    openssl genrsa -des3 -passout pass:x -out server.pass.key 2048 && \
    openssl rsa -passin pass:x -in server.pass.key -out server.key && \
    rm server.pass.key && \
    openssl req -new -key server.key -out server.csr \
    -subj "/C=US/ST=Tennessee/L=Nashville/O=OrgName/OU=IT Department/CN=localhost" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

# Download Latest Version of ChurchCRM
RUN crmlatest=$(curl -s https://api.github.com/repos/churchCRM/CRM/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4); \
    wget $crmlatest; \
    unzip -q *.zip


# Setup a new image that copies files from crmandssl into their correct locations. Pulling from the Apache Alpine repo
FROM httpd:2-alpine

# Install neccessary packages
RUN echo "@edge http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@community http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "@testing http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update --repository http://dl-3.alpinelinux.org/alpine/edge/main \
               --repository http://dl-3.alpinelinux.org/alpine/edge/community \
               --repository http://dl-3.alpinelinux.org/alpine/edge/testing && \
    apk add --upgrade apk-tools@edge && \
    apk upgrade && \
    apk add --no-cache \
    curl \
    libressl \
    openssl \
    php7 \
    php7-apache2 \
    php7-apcu \
    php7-curl \
    php7-exif \
    php7-fileinfo \
    php7-gd \
    php7-gettext \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqli \
    php7-mysqlnd \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-session \
    php7-sqlite3 \
    php7-xml && \
    ln -s /usr/lib/apache2/mod_php7.so /usr/local/apache2/modules && \
    cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Copy Apache configurations
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

# Copy certificates into image
COPY --from=crmandssl /server.key /usr/local/apache2/conf/
COPY --from=crmandssl /server.crt /usr/local/apache2/conf/
COPY --from=crmandssl /churchcrm/ /usr/local/apache2/htdocs/

# Copy CRM setup file into image
COPY ./configsetup /usr/local/bin

# Set work directory to the web host path
WORKDIR /usr/local/apache2/htdocs/

# Modify php.ini and set config setup to be an executable
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 16M/g" /etc/php7/php.ini && \
    sed -i "s/post_max_size = 8M/post_max_size = 32M/g" /etc/php7/php.ini && \
    chmod +x /usr/local/bin/configsetup

# Run the configsetup file on container start
ENTRYPOINT ["/usr/local/bin/configsetup"]
CMD ["httpd-foreground"]
