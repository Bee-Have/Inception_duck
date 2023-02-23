#!/bin/bash

# check if docker
if ! type docker > /dev/null;
then
	# ubuntu
	sudo apt-get -y update
	sudo apt-get -y install curl

	# install docker
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh -y get-docker.sh
fi

# check if docker-compose is installed
if ! type docker-compose > /dev/null;
then
	# ubuntu
	sudo apt-get -y update
	sudo apt-get -y install curl

	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
fi

# check if apache is installed
if type apache &> /dev/null;
then
	sudo apt-get purge apache2
	sudo apt-get -y autoremove
	sudo rm -rf /etc/apache2
fi

# check if domain already in /etc/hosts
if [ `cat /etc/hosts | grep amarini-.42.fr | wc -l` -eq 0 ]
then
	sudo sed -i.bak '1 a\172.17.0.1      amarini-.42.fr' /etc/hosts
fi

touch .finished