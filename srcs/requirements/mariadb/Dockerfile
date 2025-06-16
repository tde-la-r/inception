FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/mariadb.conf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod -v 0644 /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/install_mysql.sh /usr/local/bin/install_mysql.sh
RUN chmod +x /usr/local/bin/install_mysql.sh

RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql

CMD [ "/usr/local/bin/install_mysql.sh" ]
