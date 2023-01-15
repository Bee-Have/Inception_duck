#!/bin/sh

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
