FROM phpdockerio/php74-fpm:latest
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install  php7.4-mysql php7.4-intl php7.4-gd php-imagick php7.4-sqlite3 php7.4-phpdbg \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install zsh
RUN apt-get update \
    && apt-get -y install zsh

# Install mysqldump
RUN apt-get update \
    && apt-get -y install mysql-client

# Install sendail
RUN apt-get update \
    && apt-get -y install sendmail

# Install git
RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
