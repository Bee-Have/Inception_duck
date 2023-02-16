#!/bin/bash

# if [ ! -f ${MYSQL_PATH}/mysql_initialized ]; then

	# mysql_install_db --user=root --datadir=${MYSQL_PATH} --basedir=/usr --rpm > /dev/null
	# mysqld_safe &

	# sleep 2

	# touch tmpfile
	# chmod 777 tmpfile

	# cat > tmpfile << EOF
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "USE mysql;"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE IF EXISTS test;"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test';"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "ALTER USER IF EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%';"
	# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
# EOF
	# mysql -u root -p$MYSQL_ROOT_PASSWORD < tmpfile

	# sleep 2

	# mysqladmin -uroot -p"$MYSQL_ROOT_PASSWORD" shutdown
	# touch ${MYSQL_PATH}/mysql_initialized
	# rm -f tmpfile
# fi

# sleep 1

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

# service mysql restart
exec /usr/sbin/mysqld --datadir=${MYSQL_PATH} --user=root