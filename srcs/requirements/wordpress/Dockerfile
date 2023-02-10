FROM debian:buster

LABEL maintainer="amarini-@student.42.fr"

RUN apt-get -y update && apt-get -y upgrade
RUN apt autoremove && apt-get -y install wget mariadb-client
RUN apt-get -y install php7.3-fpm php7.3-mysqli php7.3-mbstring php7.3-pdo php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
RUN rm latest.tar.gz
RUN chmod 777 -R /wordpress/
# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN php wp-cli.phar --info
# RUN chmod +x wp-cli.phar
# RUN mv wp-cli.phar /usr/bin/wp
# RUN chmod 755 /usr/bin/wp
# RUN mkdir -p /run/php

RUN mkdir -p /var/log/php-fpm
COPY wp-config.php /wordpress/wp-config.php
# RUN wp --path=/var/www/html --allow-root core download

RUN adduser --system --shell /bin/bash --gecos "nginx" --group --disabled-password nginx

RUN chown -R nginx:nginx /wordpress/

# RUN service php7.3-fpm start

COPY wp_start.sh /run/php/wp_start.sh
COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod 777 /run/php/wp_start.sh

EXPOSE 9000

ENTRYPOINT [ "/bin/bash", "/run/php/wp_start.sh" ]