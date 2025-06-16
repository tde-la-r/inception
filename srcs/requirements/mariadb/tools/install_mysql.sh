#!/bin/sh

#MARIADB_USER=tdelar
#MARIADB_PASSWORD=GFJ54DGHFGD422S
#MARIADB_DATABASE=tdelar_db

#mariadb-install-db

# Start the service
service mariadb start

#sleep 5

# Create the database named $MARIADB_DATABASE if it does not exist
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"

# Create a new Mariadb user with it's Password
mariadb -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"

# Grant all privilage to the user on the specified database
mariadb -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%' ;"

# Reload the privilege to assur the user now have the permissions
mariadb -e "FLUSH PRIVILEGES;"

# Shutdown the server
service mariadb stop

# Restart the server
mariadbd-safe
#mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking=0 --bind-address=0.0.0.0 &
