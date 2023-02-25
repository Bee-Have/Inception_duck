SETUP = .finished

all: $(SETUP) build

build:
	cd srcs && docker-compose up -d

$(SETUP):
	$(shell bash inception_setup.sh)

logs:
	cd srcs && docker-compose logs

backup:
	docker exec wordpress sh -c "wp --path=/var/www --allow-root db export wp_site_db.sql"
	docker cp wordpress:/wp_site_db.sql ./srcs/requirements/mariadb/wp_site_db.sql

clean:
	cd srcs && docker-compose down --remove-orphans

re: clean
	cd srcs && docker-compose up -d

fclean:
	cd srcs && docker-compose down -v --remove-orphans
	docker system prune -a
	$(shell sed -i.bak '/amarini-.42.fr/d' /etc/hosts)
	rm -f $(SETUP)

.PHONY: all build logs backup clean re fclean