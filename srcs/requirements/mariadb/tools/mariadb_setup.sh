#!/bin/sh

# On s'assure que les dossiers de runtime existent
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialisation du dossier DATA si vide
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base de données..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# On crée le fichier temporaire dans un endroit sûr
tfile=`mktemp`
if [ ! -f "$tfile" ]; then
    return 1
fi

cat << EOF > $tfile
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# FIX DES PERMISSIONS : On donne le fichier à l'utilisateur mysql
chown mysql:mysql $tfile

echo "Démarrage de MariaDB..."
# On lance mysqld
exec mysqld --user=mysql --datadir=/var/lib/mysql --init-file=$tfile