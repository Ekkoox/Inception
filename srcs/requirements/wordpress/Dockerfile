FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# On installe wp-cli pour automatiser la conf de WordPress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configuration de PHP-FPM pour qu'il écoute sur le port 9000 (pas sur un socket)
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

# Dossier de travail
WORKDIR /var/www/wordpress

# Script de setup
COPY tools/wordpress_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress_setup.sh

# On crée le dossier /run/php sinon PHP-FPM refuse de démarrer
RUN mkdir -p /run/php

ENTRYPOINT ["wordpress_setup.sh"]