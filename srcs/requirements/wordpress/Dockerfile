FROM debian:buster

LABEL maintainer="amarini-@student.42.fr"

ARG MYSQL_DATABASE
ARG MYSQL_ADMIN_USER
ARG MYSQL_ADMIN_PASSWORD
ARG DB_HOST
ARG MYSQL_USER
ARG WP_PATH

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install curl
RUN apt-get -y install mariadb-client
RUN apt-get -y install php7.3-fpm php7.3-mysqli

COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY amarini.conf /etc/php/7.3/fpm/amarini.conf
RUN mkdir -p /run/php/

RUN useradd -ms /bin/bash www
RUN usermod -a -G www www

RUN mkdir -p ${WP_PATH}
RUN chown -R www:www ${WP_PATH}

RUN useradd -ms /bin/bash ${MYSQL_ADMIN_USER}
RUN usermod -a -G sudo ${MYSQL_ADMIN_USER}
RUN useradd ${MYSQL_USER}
RUN usermod -a -G users ${MYSQL_USER}

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chown -R www:www /usr/local/bin/wp

WORKDIR ${WP_PATH}
RUN rm -rf ${WP_PATH}/wp-config.php

WORKDIR /

COPY wp_start.sh /run/wp_start.sh
RUN chmod +x /run/wp_start.sh

EXPOSE 9000