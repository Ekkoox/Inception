FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Création du dossier pour le SSL
RUN mkdir -p /etc/nginx/ssl

# Génération du certificat auto-signé
# Remplace 'enschnei' par ton propre login si besoin
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=enschnei.42.fr/UID=enschnei"

# Copie du fichier de configuration
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Port 443 pour le HTTPS
EXPOSE 443

# Lancement de Nginx au premier plan
CMD ["nginx", "-g", "daemon off;"]