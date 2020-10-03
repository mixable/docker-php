# Select image from https://hub.docker.com/_/php/
FROM php:7.4-fpm

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y install libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libonig-dev libzip-dev \
    && apt-get -y --no-install-recommends install  php7.4-mbstring php7.4-intl php7.4-gd php7.4-curl php-imagick php7.4-sqlite3 php7.4-phpdbg php7.4-opcache php7.4-json \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install zsh
RUN apt-get update \
    && apt-get -y install zsh

# Install mysqldump
RUN apt-get update \
    && apt-get -y install mariadb-client

# Install sendail
RUN apt-get update \
    && apt-get -y install sendmail

RUN pecl install mcrypt
RUN pecl install xdebug

# Install git
#RUN apt-get update \
#    && apt-get -y install git \
#    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*