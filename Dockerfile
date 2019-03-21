FROM debian:stretch
RUN apt-get update

#install common web stuffs
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-get install -y apache2 php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-geoip php7.0-gmp php7.0-imap php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-memcached php7.0-msgpack php7.0-mysql php7.0-opcache php7.0-pgsql php7.0-soap php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-zip
RUN a2enmod ssl
RUN a2ensite  default-ssl.conf
RUN apt-get install -y postgresql-client
RUN apt-get install -y vim curl wget zip unzip make

#install git
RUN apt-get install -y git
ARG GIT_CONFIG_FILE
RUN echo "$GIT_CONFIG_FILE" > /root/.gitconfig
RUN mkdir -p  /root/personal-linux-config
RUN wget https://raw.githubusercontent.com/benIT/personal-linux-config/master/.gitconfig -P /root/personal-linux-config

#install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

#install nodejs v4
RUN apt-get install -y xz-utils
ARG VERSION=v4.8.0
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
RUN npm install --global yarn@1.12.3
RUN ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/lib/node_modules/yarn/bin/yarn /usr/local/bin/yarn

#install phing
RUN wget https://www.phing.info/get/phing-latest.phar -P /tmp
RUN mv /tmp/phing-latest.phar /usr/local/bin/phing
RUN chmod +x /usr/local/bin/phing

RUN apt-get clean
RUN rm /var/www/html/index.html

#environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD html/ /var/www/html/

EXPOSE 80 443 22

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]