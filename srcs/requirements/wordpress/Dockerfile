FROM debian
# WORDPRESS
WORKDIR /var/www/html
RUN apt-get -y update && apt-get install -y wget
RUN wget http://wordpress.org/latest.tar.gz
RUN tar xfz latest.tar.gz
RUN mv wordpress/* ./
RUN rm -f latest.tar.gz
COPY wp-config.php /var/www/html/wp-config.php

# PHP
RUN apt -y update && apt-get install -y software-properties-common
RUN apt -y install lsb-release apt-transport-https ca-certificates 
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get -y update && apt-get -y install php7.3 && apt-get -y install php7.3-fpm
RUN groupadd wordpress_user && useradd -g wordpress_user wordpress_user

# NGINX
RUN apt-get -y update && apt-get -y install nginx
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/http.d/default.conf
COPY php_fpm_setup.sh php_fpm_setup.sh
EXPOSE 8080/tcp
CMD ["/bin/sh", "./php_fpm_setup.sh"]

