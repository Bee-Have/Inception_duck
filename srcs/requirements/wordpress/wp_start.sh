#!/bin/bash

wp core download --path=$WP_PATH --allow-root
wp config create --path=$WP_PATH --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_ADMIN_USER --dbpass=$MYSQL_ADMIN_PASSWORD --dbhost=$DB_HOST --dbcharset=utf8 --allow-root --skip-check

/usr/sbin/php-fpm7.3 -F -R