DIR_WP = /home/amarini-/data/html
DIR_MYSQL = /home/amarini-/data/mysql

VOLUME_WP = srcs/wordpress_volume
VOLUME_MYSQL = srcs/mysql_volume

all:
	sudo mkdir -p $(DIR_WP)
	sudo mkdir -p $(DIR_MYSQL)
	cd srcs && docker-compose up --build -d

logs:
	cd srcs && docker-compose logs

clean:
	cd srcs && docker-compose down -v
	sudo rm -rf $(VOLUME_WP)
	sudo rm -rf $(VOLUME_MYSQL)
	sudo rm -rf $(DIR_WP)
	sudo rm -rf $(DIR_MYSQL)

re: clean
	docker-compose up --build --force-recreate -d

fclean: clean
	docker system prune -a

.PHONY: all logs clean re fclean