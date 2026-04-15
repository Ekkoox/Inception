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