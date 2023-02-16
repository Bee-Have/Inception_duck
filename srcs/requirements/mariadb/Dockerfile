FROM debian:buster

ARG MYSQL_DATABASE
ARG MYSQL_ADMIN_USER
ARG MYSQL_ADMIN_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD

RUN apt-get -y update && apt-get -u upgrade
RUN apt-get -y install mariadb-server

COPY db-server.cnf /etc/mysql/my.cnf

RUN mysql_install_db --datadir=/var/lib/mysql --user=mysql

RUN service mysql start && \
	echo "USE mysql;" | mysql -u root && \
	echo "FLUSH PRIVILEGES;" | mysql -u root && \
	echo "DELETE FROM mysql.user WHERE User='';" | mysql -u root && \
	echo "DROP DATABASE IF EXISTS test;" | mysql -u root && \
	echo "CREATE DATABASE $MYSQL_DATABASE;" | mysql -u root && \
	echo "CREATE USER '$MYSQL_ADMIN_USER'@'*';" | mysql -u root && \
	echo "SET password FOR '$MYSQL_ADMIN_USER'@'*' = password('$MYSQL_ADMIN_PASSWORD');" | mysql -u root && \
	echo "CREATE USER '$MYSQL_USER'@'*';" | mysql -u root && \
	echo "SET password FOR '$MYSQL_USER'@'*' = password('$MYSQL_USER_PASSWORD');" | mysql -u root && \
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ADMIN_USER'@'*' WITH GRANT OPTION;" | mysql -u root && \
	echo "GRANT ALL ON '$MYSQL_DATABASE'.* to '$MYSQL_ADMIN_USER'@'*' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" && \
	echo "SELECT host FROM mysql.user WHERE user = '$MYSQL_ADMIN_USER';"  | mysql -u root  && \
	echo "CREATE USER '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';" | mysql -u root && \
	echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'%';" | mysql -u root && \
	echo "REPAIR TABLE mysql.user;" | mysql -u root && \
	echo "REPAIR TABLE mysql.db;" | mysql -u root && \
	echo "FLUSH PRIVILEGES;" | mysql -u root

# RUN mysqlcheck -u root --repair --extended ${MYSQL_DATABASE}

EXPOSE 3306

CMD [ "mysqld" ]

# RUN apt-get -y update && apt-get -y upgrade && apt-get -y install aptitude
# RUN apt-get remove -y --purge *mysql*
# RUN apt-get remove -y --purge *mariadb*
# RUN rm -rf /var/lib/mysql
# RUN rm -rf /etc/mysql
# RUN apt-get autoremove
# RUN apt-get autoclean

# RUN apt-get -y update && apt-get -y upgrade && apt-get -y install mariadb-server mariadb-client

# RUN apt-get -y update && apt-get -y upgrade && apt-get -y install procps

# # RUN rm -rf /var/lib/mysql
# RUN mkdir -p /var/run/mysqld /var/lib/mysql
# RUN chown -R mysql:mysql /var/run/mysqld/ /var/lib/mysql/
# RUN chmod 777 -R /var/run/mysqld /var/lib/mysql

# COPY db-server.cnf /etc/mysql/my.cnf
# COPY mysql_setup.sh /home/script/mysql_setup.sh

# RUN chown -R mysql:mysql /etc/mysql
# RUN chmod 777 /home/script/mysql_setup.sh

# EXPOSE 3306

# ENTRYPOINT [ "sh", "/home/script/mysql_setup.sh" ]