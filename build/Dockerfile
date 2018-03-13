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
    bash \
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
    ln -s /usr/lib/apache2/mod_php7.so /usr/local/apache2/modules

# Copy Apache configurations
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

# SSL Generation
WORKDIR /usr/local/apache2/conf/

COPY ./server.csr.cnf .
COPY ./v3.ext .

RUN /bin/bash -c "openssl genrsa -des3 -passout pass:xxxx -out rootCA.key 2048" && \
    /bin/bash -c "openssl req -x509 -passin pass:xxxx -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem -config <( cat server.csr.cnf )" && \
    /bin/bash -c "openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config <( cat server.csr.cnf )" && \
    /bin/bash -c "openssl x509 -req -passin pass:xxxx -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 500 -sha256 -extfile v3.ext"

# Download Latest Version of ChurchCRM
WORKDIR /usr/local/apache2/

RUN crmlatest=$(curl -s https://api.github.com/repos/churchCRM/CRM/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4); \
    wget $crmlatest && \
    unzip -q *.zip && \
    rm -R *.zip htdocs && \
    mv churchcrm htdocs

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
