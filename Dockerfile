FROM ubuntu:focal

RUN sed -i 's|http://archive.ubuntu.com|http://mirror.first-colo.net|g' /etc/apt/sources.list

# Timezone
ENV TZ=Europe/Berlin

# Base
RUN export LC_ALL=C.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive && \
    rm /bin/sh && ln -s /bin/bash /bin/sh && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# APT
RUN apt-get update && \
    apt-get install -y \
    apt-utils

# Common
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    build-essential \
    bzip2 \
    ca-certificates \
    curl \
    openssh-client \
    rsync \
    software-properties-common \
    ssh \
    sudo \
    unzip \
    wget \
    zip

# Git
RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git

# PHP
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
    php8.0-amqp \
    php8.0-apcu \
    php-apcu-bc \
    php-gearman \
    php-geoip \
    php-gmagick \
    php8.0-memcached \
    php8.0-redis \
    php8.0-xdebug \
    php8.0-bcmath \
    php8.0-bz2 \
    php8.0-cli \
    php8.0-common \
    php8.0-curl \
    php8.0-dev \
    php8.0-gd \
    php8.0-gmp \
    php8.0-imap \
    php8.0-intl \
    php-json \
    php8.0-ldap \
    php8.0-mbstring \
    php8.0-mysql \
    php8.0-pgsql \
    php8.0-soap \
    php8.0-sqlite3 \
    php8.0-xml \
    php-xmlrpc \
    php8.0-xsl \
    php8.0-zip \
    php8.0-phpdbg

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x -o node_setup.sh && \
    bash node_setup.sh && \
    apt-get install -y nodejs && \
    npm install npm -g

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn

# Ansible
RUN apt-get install -y ansible

# SSH
RUN mkdir ~/.ssh && touch ~/.ssh_config
