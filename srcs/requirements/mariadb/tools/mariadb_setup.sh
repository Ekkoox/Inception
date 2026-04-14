#!/bin/sh

# On lance MySQL en arrière-plan
mysqld_safe --datadir='/var/lib/mysql' &

# Attente que MariaDB soit prêt
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

# Configuration via les variables d'env
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# On arrête proprement le service d'arrière-plan
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Relance MariaDB au premier plan (PID 1) en appelant directement le binaire
exec mariadbd --user=mysql --datadir=/var/lib/mysql