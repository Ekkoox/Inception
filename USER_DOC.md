# USER_DOC.md — User Documentation

## 🌟 Services
- **NGINX**: Secure HTTPS entry point.
- **WordPress**: Functional website platform.
- **MariaDB**: Secure database storage.

## 🚀 Start/Stop
- **Start**: Run `make` at the project root.
- **Stop**: Run `make down`.

## 🌐 Access
- **Website**: [https://enschnei.42.fr](https://enschnei.42.fr)
- **Admin**: [https://enschnei.42.fr/wp-admin](https://enschnei.42.fr/wp-admin)
- *Note: Accept the SSL warning in your browser to proceed.*

## 🔑 Credentials
- Passwords are in `srcs/.env`.
- To change a password, update the file and run `make re`.

## ✅ Health Check
- Run `docker ps` to ensure all 3 containers are "Up".
- Run `docker volume <name_volume>` to check the volume of the containers.
- Run `cat /etc/os-release` to check the debian version use.
- Run `curl -vk https://enschnei.42.fr:<port>` to check if the web site work.
- Run `docker exec -it mariadb mariadb -u root -p` for see if there is data in mariadb.
- Run `openssl s_client -connect enschnei.42.fr:443 -tls1_3` for check the certificate TLS is good.
