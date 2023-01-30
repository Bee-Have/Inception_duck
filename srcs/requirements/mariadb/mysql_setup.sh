if [ ! -f ${MYSQL_PATH}/mysql_initialized ]; then

	mysql_install_db --user=mysql --datadir=${MYSQL_PATH} --basedir=/usr --rpm > /dev/null
	mysqld_safe &

	MYSQL_UP=0
	while [ $MYSQL_UP -eq 0 ]; do
		sleep 5
		ps aux | grep -v "grep" | grep "mysqld_safe"
		if [ $? -eq 0 ]; then
			MYSQL_UP=1
		fi
	done

	touch tmpfile
	chmod 777 tmpfile

	cat > tmpfile << EOF
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
CREATE DATABASE ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	mysql -u root -p$ROOT_PASSWORD < tmpfile

	sleep 4

	mysqladmin -u root -p"$ROOT_PASSWORD" shutdown
	touch ${MYSQL_PATH}/mysql_initialized
	rm -f tmpfile
fi

sleep 1

exec /usr/sbin/mysqld --user=root