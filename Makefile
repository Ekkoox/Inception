NAME = Inception

DATA_PATH = /Users/schneider/Projet_Code/Inception/data

all: build up

build :
		@mariadb -p  $(DATA_PATH)/mariadb
		@mariadb -p  $(DATA_PATH)/wordpress
		$(DOCKER_COMPOSE) docker-compose

up :
		$(DOCKER_COMPOSE) up -d

down:
		$(DOCKER_COMPOSE) down

clean :
		$(DOCKER_COMPOSE) down -v --rmi all

fclean : 
		clean
		@rm -rf $(DATA_PATH)
		@docker system prune -af

re : fclean all