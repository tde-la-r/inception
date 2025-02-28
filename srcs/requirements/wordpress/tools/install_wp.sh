#!/bin/bash

echo "Waiting for MariaDB to be available..."
for i in {1..60}; do
    if mysqladmin ping -h "${WORDPRESS_DB_HOST}" -u "${MARIADB_USER}" "--password=${MARIADB_PASSWORD}" --silent; then
        echo "MariaDB is up."
        break
    else
        echo "MariaDB not available, retrying in 10 seconds..."
        sleep 10
    fi
done

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download
wp config create    --allow-root \
					--dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'
wp core install --url="bvasseur.42.fr" \
                --title="BVASSEUR AKA LE MEILLEUR MJ" \
                --admin_user=${WORDPRESS_ADMIN_USR} \
                --admin_password=${WORDPRESS_ADMIN_PWD} \
                --admin_email=${WORDPRESS_ADMIN_MAIL} \
                --allow-root
wp user create ${WORDPRESS_USR} ${WORDPRESS_MAIL} --role=author --user_pass=${WORDPRESS_PWD} --allow-root
chmod -R 775 wp-content
exec php-fpm7.4 -F

