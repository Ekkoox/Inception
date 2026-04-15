# DEV_DOC.md — Developer Documentation

## 🛠 1. Environment Setup
- **Prerequisites**: Docker, Docker Compose, and Make.
- **Structure**: Each service is in `srcs/requirements/` with its own Dockerfile and config.
- **Secrets**: Defined in `srcs/.env`.

## 🏗 2. Build and Launch
- `make build`: Triggers the docker build process.
- `make up`: Starts containers in detached mode.
- `make`: Executes both build and up.

## 🐚 3. Container Management
- **Logs**: `docker compose -f srcs/docker-compose.yml logs -f`
- **Shell**: `docker exec -it [container_name] sh`
- **Cleanup**: `make fclean` to remove everything including volumes.

## ⚙️ 4. Data Persistence
Data is stored in Docker Named Volumes:
- `wp_data`: WordPress files (`/var/www/wordpress`).
- `db_data`: MariaDB files (`/var/lib/mysql`).