FROM debian:stretch
RUN apt-get update
RUN apt-get install -y apache2 composer php7.0 libapache2-mod-php7.0 php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-imap php7.0-mbstring php7.0-xml
RUN apt-get install -y postgresql-client
RUN apt-get install -y vim curl zip unzip
RUN apt-get clean
RUN rm /var/www/html/index.html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV http_proxy $http_proxy
ENV APACHE_LOG_DIR /var/log/apache2
ADD html/ /var/www/html/
EXPOSE 80 443 22
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]