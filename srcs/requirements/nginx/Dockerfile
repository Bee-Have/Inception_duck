FROM debian
RUN apt-get -y update && apt-get -y install nginx
COPY conf /etc/nginx/sites-available/conf
COPY setup.sh setup.sh
EXPOSE 8080/tcp
CMD ["/bin/sh", "./setup.sh"]
