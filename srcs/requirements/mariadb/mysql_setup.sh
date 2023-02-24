#!/bin/bash

mysql_install_db --user=mysql --datadir=${MYSQL_PATH} --basedir=/usr --rpm > /dev/null
mysqld_safe &

sleep 2

mysql -u root -e "USE mysql;"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "SET password FOR '${MYSQL_ADMIN_USER}'@'localhost' = password('${MYSQL_ADMIN_PASSWORD}');"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"

mysqlcheck --repair --all-databases
mysqladmin -uroot shutdown

exec /usr/sbin/mysqld --datadir=${MYSQL_PATH} --user=root