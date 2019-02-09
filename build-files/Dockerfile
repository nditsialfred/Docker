FROM 7.3-apache
MAINTAINER ChurchCRM

RUN mkdir /web/churchcrm

COPY httpd.conf /etc/apache2
COPY 60-churchcrm /etc/run_always

RUN chmod +x /etc/run_always/60-churchcrm

# Enable Terminal
ENV TERM xterm
