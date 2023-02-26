FROM debian:buster

ARG MYSQL_DATABASE
ARG MYSQL_ADMIN_USER
ARG MYSQL_ADMIN_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_PATH

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install mariadb-server

RUN mkdir -p ${MYSQL_PATH}

COPY db-server.cnf /etc/mysql/my.cnf
COPY wp_site_db.sql ${MYSQL_PATH}/wp_site_db.sql

RUN mysql_install_db --datadir=${MYSQL_PATH} --user=mysql

RUN service mysql start && \
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
	echo "FLUSH PRIVILEGES;" | mysql -u root && \
	mysql -u root ${MYSQL_DATABASE} < ${MYSQL_PATH}/wp_site_db.sql

EXPOSE 3306

CMD [ "mysqld" ]