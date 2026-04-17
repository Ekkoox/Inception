#!/bin/sh

# On s'assure que le dossier de runtime existe
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Si la base de données n'existe pas encore
if [ ! -d "/var/lib/mysql/mysql" ]; then

    echo "Initialisation de la base de données MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # On lance MariaDB temporairement pour configurer les users
    # sans passer par le réseau pour plus de sécurité au début
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
    pid="$!"

    # On attend que MariaDB réponde
    until mysqladmin ping > /dev/null 2>&1; do
        sleep 1
    done

    # Configuration des accès
    mysql -u root << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # On arrête l'instance temporaire
    kill "$pid"
    wait "$pid"
fi

echo "MariaDB configurée. Démarrage du service..."

# Lancement final (c'est ça qui va permettre à WordPress de se connecter)
exec mysqld --user=mysql --datadir=/var/lib/mysql