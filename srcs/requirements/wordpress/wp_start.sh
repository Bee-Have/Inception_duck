#!/bin/bash

sleep 20

# wp --path=${WP_PATH} --allow-root core is-installed
# if [ $? -ne 0 ]
# then
# wp --path=${WP_PATH} --allow-root core download
# 	# there is no config.php in the project. this line create such file and directly put it in the right place
# 	wp config create --path=${WP_PATH} --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${DB_HOST} --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
# 	# setup the website information for wordpress in the database
# 	wp --allow-root core install --path=${WP_PATH} --url=${MY_URL} --title="${TITLE}" --admin_user=${MYSQL_USER} --admin_password=${MYSQL_PASSWORD} --admin_email=amarini-@student.42.fr
# 	# create user ogenser hehe oscar ma boy
# 	wp --path=${WP_PATH} --allow-root user create ogenser ogenser@student.42.fr --role=author --user_pass=ogenser
# 	# create user lbetranc leti <3
# 	wp --path=${WP_PATH} --allow-root user create lbetranc lbetranc@student.42.fr --role=author --user_pass=lbetranc
# fi

/usr/sbin/php-fpm7.3 -F