NAME = inception

# Chemins
SRCS_DIR = ./srcs
DOCKER_COMPOSE = docker-compose -f $(SRCS_DIR)/docker-compose.yml
DATA_PATH = /Users/schneider/Projet_Code/Inception/data

# Couleurs pour le terminal
GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

all: build up

# Création des dossiers nécessaires avant le build
build:
	@echo "$(GREEN)Creating data directories...$(RESET)"
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@echo "$(GREEN)Building images...$(RESET)"
	$(DOCKER_COMPOSE) build

up:
	@echo "$(GREEN)Starting containers...$(RESET)"
	$(DOCKER_COMPOSE) up -d

down:
	@echo "$(RED)Stopping containers...$(RESET)"
	$(DOCKER_COMPOSE) down

# Supprime les containers, les images liées au projet et les volumes anonymes
clean:
	@echo "$(RED)Cleaning containers and images...$(RESET)"
	$(DOCKER_COMPOSE) down -v --rmi all

# Nettoyage total : clean + suppression physique des dossiers de données + prune
fclean: clean
	@echo "$(RED)Deleting data folders and pruning system...$(RESET)"
	@sudo rm -rf $(DATA_PATH)
	@docker system prune -af

re: fclean all

.PHONY: all build up down clean fclean re