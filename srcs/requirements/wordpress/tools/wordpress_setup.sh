#!/bin/sh

mkdir -p /var/www/wordpress
cd /var/www/wordpress

set -x

echo "Vérification de la connexion à MariaDB..."

max_tries=30
count=0
while ! mariadb-admin ping -h"mariadb" --user="${SQL_USER}" --password="${SQL_PASSWORD}" --silent; do
    echo "MariaDB n'est pas encore prêt ($count/$max_tries)..."
    sleep 2
    count=$((count + 1))
    if [ $count -eq $max_tries ]; then
        echo "Erreur : MariaDB n'a pas répondu à temps."
        exit 1
    fi
done

echo "MariaDB est UP ! Configuration de WordPress..."

cd /var/www/wordpress

if [ ! -f "/var/www/wordpress/wp-config.php" ] || ! wp core is-installed --allow-root; then

    echo "Téléchargement de WordPress..."
    wp core download --allow-root --force

    echo "Création du fichier wp-config.php..."
    wp config create --allow-root --skip-check\
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost=mariadb

    echo "Installation du site principal..."
    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="${WP_SITE_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_MAIL}" \
        --skip-email

    echo "Création du second utilisateur..."
    wp user create "${WP_USER1}" "${WP_USER1_MAIL}" \
        --user_pass="${WP_USER1_PASSWORD}" \
        --role=author \
        --allow-root
    
    echo "WordPress a été installé avec succès !"
else
    echo "WordPress est déjà configuré."
fi

chown -R www-data:www-data /var/www/wordpress

echo "Démarrage de PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F