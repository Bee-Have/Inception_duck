#!/bin/bash

sleep 10

wp --path=${WP_PATH} --allow-root core is-installed

if [ $? -ne 0 ]
then
	wp config create --path=${WP_PATH} --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${DB_HOST} --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp --allow-root core install --path=${WP_PATH} --url=${MY_URL} --title="${TITLE}" --admin_user=${MYSQL_USER} --admin_password=${MYSQL_PASSWORD} --admin_email=wluong@student.42.fr

	# add user ogenser hehe oscar ma boy
	wp --path=${WP_PATH} --allow-root user create ogenser ogenser@student.42.fr --role=author --user_pass=ogenser
	# add user lbetranc leti <3
	wp --path=${WP_PATH} --allow-root user create lbetranc lbetranc@student.42.fr --role=author --user_pass=lbetranc
fi

php-fpm7.3 -F