FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y  wget \
                        curl \
                        php7.4 \
						php7.4-fpm \
						php7.4-mysql \
						mariadb-client
RUN mkdir -p /var/www
RUN wget https://fr.wordpress.org/wordpress-6.7.2-fr_FR.tar.gz -O /var/www/wp.gz
RUN cd /var/www && tar -xf wp.gz && rm wp.gz
RUN chown -R root:root /var/www/wordpress

COPY conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/install_wp.sh /usr/local/bin/install_wp.sh
RUN chmod +x /usr/local/bin/install_mysql.sh

CMD /usr/local/bin/install_wp.sh
