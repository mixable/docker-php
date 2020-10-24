# see https://github.com/chialab/docker-php
FROM php:7.4-fpm
LABEL maintainer="dev@chialab.io"

# Download script to install PHP extensions and dependencies
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
      curl \
      git \
      zip unzip \
    && install-php-extensions \
      bcmath \
      bz2 \
      calendar \
      exif \
      gd \
      intl \
      ldap \
      memcached \
      mysqli \
      opcache \
      pdo_mysql \
      pdo_pgsql \
      pgsql \
      redis \
      soap \
      xsl \
      zip \
      sockets \
      pdo_sqlsrv \
      sqlsrv
# already installed:
#      iconv \
#      mbstring \

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1

# Install SSH
RUN apt-get update && apt-get -y install openssh-client
RUN apt-get update && apt-get -y install sshpass
# Install zsh
RUN apt-get update && apt-get -y install zsh
# Install mysqldump
RUN apt-get update && apt-get -y install mariadb-client
# Install sendmail
RUN apt-get update && apt-get -y install sendmail
# Install mcrypt
RUN apt-get update \
    && apt-get -y install libmcrypt-dev \
    && pecl install mcrypt \
    && docker-php-ext-enable mcrypt
# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug