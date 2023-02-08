#!/bin/bash

if [ ! -f ${MYSQL_PATH}/mysql_initialized ]; then

	mysql_install_db --user=root --datadir=${MYSQL_PATH} --basedir=/usr --rpm > /dev/null
	mysqld_safe &

	sleep 2

	touch tmpfile
	chmod 777 tmpfile

	cat > tmpfile << EOF
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	mysql -u root -p$MYSQL_ROOT_PASSWORD < tmpfile

	sleep 2

	mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
	touch ${MYSQL_PATH}/mysql_initialized
	rm -f tmpfile
fi

sleep 1

# service mysql restart
exec /usr/sbin/mysqld --datadir=${MYSQL_PATH} --user=root