FROM debian:buster

LABEL maintainer="amarini-@student.42.fr"

# RUN adduser -u 82 www-data www-data

# RUN apt-get update && apt-get upgrade
# RUN apt-get -y install wget
# RUN apt-get -y install php7.3
# RUN apt-get -y install php7.3-mysqli
# RUN apt-get -y install php7.3-fpm
# RUN apt-get -y install php7.3-curl
# RUN apt-get -y install php7.3-dom
# RUN apt-get -y install php7.3-exif
# RUN apt-get -y install php7.3-fileinfo
# RUN apt-get -y install php7.3-mbstring
# RUN apt-get -y install php7.3-zip
# RUN apt-get -y install php7.3-opcache
# RUN apt-get -y install php7.3-gd
# RUN apt-get -y install php7.3-intl
# RUN apt-get -y install php7.3-cgi
# RUN mkdir -p /var/www/html/
# RUN wget -O /var/www/html/latest.tar.gz http://wordpress.org/latest.tar.gz

# # maybe this is wrong ?
# COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf

# WORKDIR /var/www/html/
# RUN tar -xzvf latest.tar.gz
# RUN rm latest.tar.gz

# RUN chown -R www-data:www-data /var/www/html/wordpress
# RUN chmod -R o-rwx /var/www/html/wordpress

# WORKDIR /var/www/html/wordpress

# COPY wp-config.php /var/www/html/wordpress/wp-config.php

# RUN service php7.3-fpm start


# RUN apt-get -y update && apt-get -y upgrade
# RUN apt autoremove && apt-get -y install wget mariadb-client
# RUN apt-get -y install php7.3-fpm php7.3-mysqli php7.3-mbstring php7.3-pdo php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# RUN wget https://wordpress.org/latest.tar.gz
# RUN tar -xzvf latest.tar.gz
# RUN rm latest.tar.gz
# # RUN chmod 777 -R /wordpress/
# RUN mkdir -p /var/log/php-fpm
# COPY wp-config.php /wordpress/wp-config.php
# RUN adduser --system --shell /bin/bash --gecos "nginx" --group --disabled-password nginx

# RUN chown -R nginx:nginx /wordpress/
# COPY wp_start.sh /run/php/wp_start.sh
# COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf
# RUN chmod 777 /run/php/wp_start.sh

# EXPOSE 9000

# ENTRYPOINT [ "bash", "/run/php/wp_start.sh" ]

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
COPY www.conf /etc/php/7.3/fpm/www.conf

RUN mkdir -p /run/php/

RUN useradd -ms /bin/bash www
RUN usermod -a -G www www

RUN mkdir -p /var/www/
RUN chown -R www:www /var/www

RUN useradd -ms /bin/bash ${MYSQL_ADMIN_USER}
RUN usermod -a -G sudo ${MYSQL_ADMIN_USER}
RUN useradd ${MYSQL_USER}
RUN usermod -a -G users ${MYSQL_USER}

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chown -R www:www /usr/local/bin/wp

WORKDIR /var/www/
RUN rm -rf /var/www/wp-config.php
RUN wp core download --allow-root
RUN wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_ADMIN_USER} --dbpass=${MYSQL_ADMIN_PASSWORD} --dbhost=${DB_HOST} --dbcharset=utf8 --path=${WP_PATH} --allow-root --skip-check

WORKDIR /