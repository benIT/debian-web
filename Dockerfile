FROM debian:jessie
RUN apt-get update
RUN apt-get install -y apache2 php5 php5-curl php5-gd php5-xmlrpc php5-intl php5-pgsql
RUN a2enmod ssl
RUN a2ensite  default-ssl.conf
RUN apt-get install -y postgresql-client
RUN apt-get install -y vim curl wget zip unzip make
RUN apt-get clean
RUN rm /var/www/html/index.html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ADD html/ /var/www/html/
EXPOSE 80 443 22
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]