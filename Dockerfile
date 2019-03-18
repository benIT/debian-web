FROM debian:jessie
RUN apt-get update

#install common web stuffs
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-get install -y apache2 php5 php5-curl php5-gd php5-xmlrpc php5-intl php5-pgsql
RUN a2enmod ssl
RUN a2ensite  default-ssl.conf
RUN apt-get install -y postgresql-client
RUN apt-get install -y vim curl wget zip unzip make

#install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

#install nodejs v4.9.1
RUN apt-get install -y xz-utils --fix-missing
ARG VERSION=v4.9.1
ARG DISTRO=linux-x64
RUN wget https://nodejs.org/download/release/$VERSION/node-$VERSION-$DISTRO.tar.xz -P /tmp
RUN ls -l /tmp/node-$VERSION-$DISTRO.tar.xz
RUN mkdir -p /usr/local/lib/nodejs
RUN tar -xJvf /tmp/node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs
RUN ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npm /usr/local/bin/npm

#install gulp
RUN npm install gulp-cli -g
RUN npm install gulp -D
RUN ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/gulp /usr/local/bin/gulp

#install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

#install phing
RUN wget https://www.phing.info/get/phing-latest.phar -P /tmp
RUN mv /tmp/phing-latest.phar /usr/local/bin/phing
RUN chmod +x /usr/local/bin/phing

RUN apt-get clean
RUN rm /var/www/html/index.html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ADD html/ /var/www/html/
EXPOSE 80 443 22
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]