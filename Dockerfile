FROM ubuntu:16.04
#FROM php:7.3.6-apache-stretch
RUN apt-get update && apt-get -y upgrade
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get --assume-yes install apache2
RUN apt-get --assume-yes install software-properties-common python-software-properties
##RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get -y upgrade
RUN apt-get --assume-yes install php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath
RUN apt-get --assume-yes install libapache2-mod-php7.0
RUN apt-get --assume-yes install curl
#RUN apt-get --assume-yes install php7.2 php7.2-cli php7.2-common
#RUN apt-get --assume-yes install php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-intl php7.2-mysql php7.2-xml php7.2-zip
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash
#RUN apt-get --assume-yes install php-phalcon
RUN apt-get --assume-yes install php7.0-phalcon
#RUN php -v 
#RUN php -m
#RUN php -r "echo Phalcon\Version::get();"
COPY index.php /srv/app/
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
#RUN a2enmod php7.0
RUN chown -R www-data:www-data /srv/app && a2enmod rewrite
RUN /etc/init.d/apache2 start
CMD /etc/init.d/apache2 start
