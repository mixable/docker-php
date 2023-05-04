# see https://github.com/chialab/docker-php
FROM php:8.2-fpm
LABEL maintainer="dev@chialab.io"

# Download script to install PHP extensions and dependencies
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

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
      sockets
# already installed:
#      iconv \
#      mbstring \
# not installable with latest php version
#      pdo_sqlsrv \
#      sqlsrv \

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
# Install rsync
RUN apt-get update && apt-get -y install rsync
# Install mcrypt
RUN apt-get update \
    && apt-get -y install libmcrypt-dev \
    && pecl install mcrypt \
    && docker-php-ext-enable mcrypt
# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
# Install pcov
RUN pecl install pcov \
    && docker-php-ext-enable pcov