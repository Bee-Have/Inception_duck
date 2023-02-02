FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install mariadb-server mariadb-client

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install procps

RUN rm -rf /var/lib/mysql
RUN mkdir -p /var/run/mysqld /var/lib/mysql
RUN chown -R mysql:mysql /var/run/mysqld/ /var/lib/mysql/
RUN chmod 777 -R /var/run/mysqld /var/lib/mysql

COPY db-server.cnf /etc/mysql/my.cnf
COPY mysql_setup.sh /home/script/mysql_setup.sh

RUN chown -R mysql:mysql /etc/mysql
RUN chmod 777 /home/script/mysql_setup.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/home/script/mysql_setup.sh" ]