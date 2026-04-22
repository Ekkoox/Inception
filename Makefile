NAME		= inception

SRCS_DIR	= ./srcs
DOCKER_COMPOSE	= sudo docker compose -f $(SRCS_DIR)/docker-compose.yml
DATA_PATH	= /home/enschnei/data

# Couleurs
GREEN		= \033[0;32m
RED		= \033[0;31m
RESET		= \033[0m

all: build up

build:
	@echo "$(GREEN)Creating data directories in $(DATA_PATH)...$(RESET)"
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo mkdir -p $(DATA_PATH)/wordpress
	@echo "$(GREEN)Building images...$(RESET)"
	$(DOCKER_COMPOSE) build

up:
	@echo "$(GREEN)Starting containers in background...$(RESET)"
	$(DOCKER_COMPOSE) up -d

down:
	@echo "$(RED)Stopping containers...$(RESET)"
	$(DOCKER_COMPOSE) down

clean:
	@echo "$(RED)Cleaning containers and images...$(RESET)"
	$(DOCKER_COMPOSE) down -v --rmi all

fclean: clean
	@echo "$(RED)Deleting data folders and pruning system...$(RESET)"
	@sudo rm -rf $(DATA_PATH)
	@sudo docker system prune -af

re: fclean all

.PHONY: all build up down clean fclean re