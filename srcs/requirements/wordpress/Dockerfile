FROM debian
# WORDPRESS
RUN apt-get -y update && apt-get -y install curl && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# PHP
RUN apt-get -y update && apt-get install -y software-properties-common wget
RUN apt -y install lsb-release apt-transport-https ca-certificates 
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get -y update && apt-get -y install php7.3 && apt-get -y install php7.3-fpm
RUN groupadd wordpress_user && useradd -g wordpress_user wordpress_user

# NGINX
RUN apt-get -y update && apt-get -y install nginx
COPY conf /etc/nginx/sites-available/conf
COPY php_fpm_setup.sh php_fpm_setup.sh
EXPOSE 8080/tcp
CMD ["/bin/sh", "./php_fpm_setup.sh"]

