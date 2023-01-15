#!/bin/sh

cd /etc/php/7.3/fpm/pool.d
touch wordpress_pool.conf

echo "[wordpress_site]" &>>wordpress_pool.conf
echo "user = wordpress_user" &>>wordpress_pool.conf
echo "group = wordpress_user" &>>wordpress_pool.conf
echo "listen = /var/run/php7.3-fpm-wordpress-site.sock" &>>wordpress_pool.conf
echo "listen.owner = www-data" &>>wordpress_pool.conf
echo "listen.group = www-data" &>>wordpress_pool.conf
echo "php_admin_value[disable_functions] = exec,passthru,shell_exec,system" &>>wordpress_pool.conf
echo "php_admin_value[disable_functions] = exec,passthru,shell_exec,system" &>>wordpress_pool.conf
echo "; Choose how the process manager will control the number of child processes." &>>wordpress_pool.conf
echo "pm = dynamic" &>>wordpress_pool.conf
echo "pm.max_children = 75" &>>wordpress_pool.conf
echo "pm.start_servers = 10" &>>wordpress_pool.conf
echo "pm.min_spare_servers = 5" &>>wordpress_pool.conf
echo "pm.max_spare_servers = 20" &>>wordpress_pool.conf
echo "pm.process_idle_timeout = 10s" &>>wordpress_pool.conf

/etc/init.d/php7.3-fpm start
# systemctl start php7.3-fpm

# nginx -t
# /etc/init.d/nginx restart
# systemctl restart nginx

#this is part of the nginx setup file

/usr/sbin/nginx -g "daemon off;"

NGINX_PROCESS=1
while [ $NGINX_PROCESS -eq 1 ]
do
	sleep 10
	ps aux | grep -v "grep" | grep "nginx"
	if [ $? -ne 0 ]
	then
		NGINX_PROCESS=0
	fi
done
