DIR_WP = $(HOME)/data/html
DIR_MYSQL = $(HOME)/data/mysql

VOLUME_WP = srcs/wordpress_volume
VOLUME_MYSQL = srcs/mysql_volume

SETUP = .finished

all: $(SETUP) build

build:
	sudo mkdir -p $(DIR_MYSQL)
	cd srcs && docker-compose up --build -d

$(SETUP):
	$(shell bash inception_setup.sh)

logs:
	cd srcs && docker-compose logs

clean:
	cd srcs && docker-compose down -v --remove-orphans
	sudo rm -rf $(VOLUME_WP)
	sudo rm -rf $(VOLUME_MYSQL)
	sudo rm -rf $(DIR_WP)
	sudo rm -rf $(DIR_MYSQL)

re: clean
	cd srcs && docker-compose up --build --force-recreate -d

fclean: clean
	docker system prune -a
	$(shell sed -i.bak '/amarini-.42.fr/d' /etc/hosts)
	rm -f $(SETUP)

.PHONY: all build logs clean re fclean