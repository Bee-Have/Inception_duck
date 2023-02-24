#!/bin/bash

wp core download --path=/var/www --allow-root
wp config create --path=/var/www --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_ADMIN_USER --dbpass=$MYSQL_ADMIN_PASSWORD --dbhost=$DB_HOST --dbcharset=utf8 --allow-root --skip-check

/usr/sbin/php-fpm7.3 -F -R