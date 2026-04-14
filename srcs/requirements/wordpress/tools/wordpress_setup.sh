#!/bin/sh

# On attend que MariaDB soit prêt
# (Une boucle est plus propre qu'un sleep fixe, mais sleep 10 dépanne bien)
sleep 10

# On se place dans le bon dossier
cd /var/www/wordpress

# Si WordPress n'est pas encore téléchargé
if [ ! -f ./wp-config.php ]; then

    # 1. Téléchargement des fichiers source de WordPress
    wp core download --allow-root

    # 2. Création du wp-config.php (Lien avec MariaDB)
    # Attention : dbhost doit correspondre au nom du service dans le docker-compose
    wp config create --allow-root \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=mariadb:3306

    # 3. Installation du site (Crée l'admin et la structure de la DB)
    # C'est ici que l'écran "Welcome" disparaît !
    wp core install --allow-root \
        --url=${DOMAIN_NAME} \
        --title=${WP_SITE_TITLE} \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --skip-email \
        --admin_email=${WP_ADMIN_MAIL}

    # 4. Création du second utilisateur (Exigence du sujet)
    # On lui donne le rôle 'author' ou 'editor'
    wp user create ${WP_USER1} ${WP_USER1_MAIL} \
        --user_pass=${WP_USER1_PASSWORD} \
        --role=author \
        --allow-root

fi

# On s'assure que les permissions sont bonnes (optionnel mais conseillé)
# chown -R www-data:www-data /var/www/wordpress

echo "WordPress is ready!"

# Lancement de PHP-FPM au premier plan (PID 1)
exec /usr/sbin/php-fpm7.4 -F