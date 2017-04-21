#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#
# To edit the 'workspace' base Image, visit its repository on Github
#    https://github.com/LaraDock/workspace
#
# To change its version, see the available Tags on the Docker Hub:
#    https://hub.docker.com/r/laradock/workspace/tags/
#

# FROM laradock/workspace:1.2

# MAINTAINER Mahmoud Zalt <mahmoud@zalt.me>

## added from Kim for php7.1
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

FROM phusion/baseimage:latest

MAINTAINER Mahmoud Zalt <mahmoud@zalt.me>

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Add the "PHP 7" ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#

# Install "PHP Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get install -y --force-yes \
        php7.1-cli \
        php7.1-common \
        php7.1-curl \
        php7.1-json \
        php7.1-xml \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-pgsql \
        php7.1-sqlite \
        php7.1-sqlite3 \
        php7.1-zip \
        php7.1-memcached \
        php7.1-gd \
        php7.1-dev \
        php7.1-bcmath \
        php7.1-gmp \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        git \
        curl \
        vim \
        nano \
        postgresql-client \
    && apt-get clean

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

# Source the bash
RUN . ~/.bashrc

#
#--------------------------------------------------------------------------
# Mandatory Software's Installation
#--------------------------------------------------------------------------
#
# Mandatory Software's such as ("php7.1-cli", "git", "vim", ....) are
# installed on the base image 'laradock/workspace' image. If you want
# to add more Software's or remove existing one, you need to edit the
# base image (https://github.com/LaraDock/workspace).
#

#
#--------------------------------------------------------------------------
# Optional Software's Installation
#--------------------------------------------------------------------------
#
# Optional Software's will only be installed if you set them to `true`
# in the `docker-compose.yml` before the build.
# Example:
#   - INSTALL_NODE=false
#   - ...
#

#####################################
# Non-Root User:
#####################################

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000
RUN groupadd -g $PGID laradock && \
    useradd -u $PUID -g laradock -m laradock

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#####################################
# Composer:
#####################################

# Add the composer.json
COPY ./composer.json /home/laradock/.composer/composer.json

# Make sure that ~/.composer belongs to laradock
RUN chown -R laradock:laradock /home/laradock/.composer
USER laradock

# Check if global install need to be ran
ARG COMPOSER_GLOBAL_INSTALL=false
ENV COMPOSER_GLOBAL_INSTALL ${COMPOSER_GLOBAL_INSTALL}
RUN if [ ${COMPOSER_GLOBAL_INSTALL} = true ]; then \
    # run the install
    composer global install \
;fi

#####################################
# Crontab
#####################################
USER root

COPY ./crontab /var/spool/cron/crontabs

#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false
COPY ./xdebug.ini /tmp/xdebug.ini
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    # Load the xdebug extension only with phpunit commands
    apt-get update && \
    apt-get install -y --allow-downgrades --allow-change-held-packages php7.1-xdebug && \
    sed -i 's/^/;/g' /etc/php/7.1/cli/conf.d/20-xdebug.ini && \
    echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/vendor/bin/phpunit'" >> ~/.bashrc && \
    cp /tmp/xdebug.ini /etc/php/7.1/cli/conf.d/xdebug.ini \
;fi
# ADD for REMOTE debugging
#COPY ./xdebug.ini /etc/php/7.1/cli/conf.d/xdebug.ini

#####################################
# ssh:
#####################################
ARG INSTALL_WORKSPACE_SSH=false
ENV INSTALL_WORKSPACE_SSH ${INSTALL_WORKSPACE_SSH}

#ADD insecure_id_rsa /tmp/id_rsa
#ADD insecure_id_rsa.pub /tmp/id_rsa.pub
COPY ./insecure_id_rsa /tmp/id_rsa
COPY ./insecure_id_rsa.pub /tmp/id_rsa.pub

RUN if [ ${INSTALL_WORKSPACE_SSH} = true ]; then \
    rm -f /etc/service/sshd/down && \
    cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
        && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
        && cat /tmp/id_rsa >> /root/.ssh/id_rsa \
        && rm -f /tmp/id_rsa* \
        && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
    && chmod 400 /root/.ssh/id_rsa \
;fi

#####################################
# MongoDB:
#####################################

# Check if Mongo needs to be installed
ARG INSTALL_MONGO=false
ENV INSTALL_MONGO ${INSTALL_MONGO}
RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongodb extension
    pecl install mongodb && \
    echo "extension=mongodb.so" > /tmp/mongodb.ini && \
    cp /tmp/mongodb.ini /etc/php/7.1/cli/conf.d/30-mongodb.ini && \
    ln /etc/php/7.1/cli/conf.d/30-mongodb.ini /etc/php/7.1/mods-available/mongodb.ini \
;fi

#####################################
# Drush:
#####################################
USER root
ENV DRUSH_VERSION 8.1.2
ARG INSTALL_DRUSH=false
ENV INSTALL_DRUSH ${INSTALL_DRUSH}
RUN if [ ${INSTALL_DRUSH} = true ]; then \
    # Install Drush 8 with the phar file.
    curl -fsSL -o /usr/local/bin/drush https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar | bash && \
    chmod +x /usr/local/bin/drush && \
    drush core-status \
;fi

USER laradock

#####################################
# Node / NVM:
#####################################

# Check if NVM needs to be installed
ARG NODE_VERSION=stable
ENV NODE_VERSION ${NODE_VERSION}
ARG INSTALL_NODE=false
ENV INSTALL_NODE ${INSTALL_NODE}
ENV NVM_DIR /home/laradock/.nvm
RUN if [ ${INSTALL_NODE} = true ]; then \
    # Install nvm (A Node Version Manager)
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.6/install.sh | bash && \
        . $NVM_DIR/nvm.sh && \
        nvm install ${NODE_VERSION} && \
        nvm use ${NODE_VERSION} && \
        nvm alias ${NODE_VERSION} && \
        npm install -g gulp bower vue-cli \
;fi

# Wouldn't execute when added to the RUN statement in the above block
# Source NVM when loading bash since ~/.profile isn't loaded on non-login shell
RUN if [ ${INSTALL_NODE} = true ]; then \
    echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc \
;fi

# Add NVM binaries to root's .bashrc
USER root

RUN if [ ${INSTALL_NODE} = true ]; then \
    echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="/home/laradock/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc \
;fi

#####################################
# YARN:
#####################################

USER laradock

ARG INSTALL_YARN=false
ENV INSTALL_YARN ${INSTALL_YARN}

RUN if [ ${INSTALL_YARN} = true ]; then \
    #npm install -g yarn \
    curl -o- -L https://yarnpkg.com/install.sh | bash && \
    echo "" >> ~/.bashrc && \
    echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/.bashrc \
;fi

# Add YARN binaries to root's .bashrc
USER root

# RUN if [ ${INSTALL_YARN} = true ]; then \
    # echo "" >> ~/.bashrc && \
    # echo 'export YARN_DIR="/home/laradock/.yarn"' >> ~/.bashrc && \
    # echo 'export PATH="$YARN_DIR/bin:$PATH"' >> ~/.bashrc \
# ;fi

#####################################
# Supervisor for laravel queue
#####################################
USER root

ARG INSTALL_SUPERVISOR=true
ENV INSTALL_SUPERVISOR ${INSTALL_SUPERVISOR}

COPY ./supervisord.conf /tmp/supervisord.conf
ADD ./supervisor.conf.d /tmp/supervisor.conf.d

RUN if [ ${INSTALL_SUPERVISOR} = true ]; then \
  apt-get update \
  && apt-get install -y supervisor \
  && groupadd supervisor \
  && usermod -a laradock -G supervisor \
  && mv /tmp/supervisord.conf /etc/supervisor/supervisord.conf \
  && mv /tmp/supervisor.conf.d/* /etc/supervisor/conf.d/ \
;fi

#####################################
# PHP Aerospike:
#####################################
USER root

ARG INSTALL_AEROSPIKE_EXTENSION=true
ENV INSTALL_AEROSPIKE_EXTENSION ${INSTALL_AEROSPIKE_EXTENSION}

# Copy aerospike configration for remote debugging
COPY ./aerospike.ini /etc/php/7.1/cli/conf.d/aerospike.ini

RUN if [ ${INSTALL_AEROSPIKE_EXTENSION} = true ]; then \
    # Install the php aerospike extension
    curl -L -o /tmp/aerospike-client-php.tar.gz "https://github.com/luciano-jr/aerospike-client-php/archive/master.tar.gz" \
    && mkdir -p aerospike-client-php \
    && tar -C aerospike-client-php -zxvf /tmp/aerospike-client-php.tar.gz --strip 1 \
    && ( \
        cd aerospike-client-php/src/aerospike \
        && phpize \
        && ./build.sh \
        && make install \
    ) \
    && rm /tmp/aerospike-client-php.tar.gz \
;fi

RUN if [ ${INSTALL_AEROSPIKE_EXTENSION} = false ]; then \
    rm /etc/php/7.1/cli/conf.d/aerospike.ini \
;fi

#####################################
# Install phatomJS
#####################################
USER root

ARG INSTALL_PHATOMJS=true
ENV INSTALL_PHATOMJS ${INSTALL_PHATOMJS}

RUN if [ ${INSTALL_PHATOMJS} = true ]; then \
    apt-get update \
    && apt-get install -y --force-yes fontconfig freetype* phantomjs \
;fi

#####################################
# Non-root user : PHPUnit path
#####################################

# add ./vendor/bin to non-root user's bashrc (needed for phpunit)
USER laradock

RUN echo "" >> ~/.bashrc && \
    echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.bashrc

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Clean up
USER root
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# execute supervisord if set
RUN if [ ${INSTALL_AEROSPIKE_EXTENSION} = true ]; then \
  supervisord -c /etc/supervisord.conf \
;fi

COPY start.sh /root/start.sh

# Set default work directory
WORKDIR /var/www

CMD ["/bin/sh", "/root/start.sh"]
