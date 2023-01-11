FROM ubuntu
# WORDPRESS
RUN apt-get -y update && apt-get -y install curl && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# NGINX
RUN apt-get -y update && apt-get -y install nginx
COPY conf /etc/nginx/sites-available/conf
EXPOSE 80/tcp
CMD ["/usr/sbin/nginx", "-g", "deamon off;"]

# PHP
RUN apt-get -y update && apt-get -y install php7.3-fpm
RUN groupadd wordpress_user && useradd -g wordpress_user wordpress_user
CMD ["sh", "php_fpm_setup.sh;"]

