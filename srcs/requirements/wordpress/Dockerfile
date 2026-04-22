FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    php8.2 \
    php-fpm \
    php-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /var/www/wordpress

COPY tools/wordpress_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress_setup.sh

RUN mkdir -p /run/php

ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]