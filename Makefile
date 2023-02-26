SETUP = .finished

MARIADB_VOLUME = /home/amarini-/data/mysql
WORDPRESS_VOLUME = /home/amarini-/data/html

all: $(SETUP) build

build:
	sudo mkdir -p $(MARIADB_VOLUME)
	sudo mkdir -p $(WORDPRESS_VOLUME)
	cd srcs && docker-compose up -d

$(SETUP):
	$(shell bash inception_setup.sh)

logs:
	cd srcs && docker-compose logs

backup:
	cd srcs && docker exec wordpress sh -c "wp --path=${WP_PATH} --allow-root db export wp_site_db.sql"
	docker cp wordpress:/wp_site_db.sql ./srcs/requirements/mariadb/wp_site_db.sql

clean:
	cd srcs && docker-compose down --remove-orphans

re: clean build

fclean: clean
	docker system prune -a
	$(shell sed -i.bak '/amarini-.42.fr/d' /etc/hosts)
	rm -f $(SETUP)

.PHONY: all build logs backup clean re fclean