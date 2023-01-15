FROM ubuntu
RUN apt-get -y update && apt-get -y install nginx
COPY conf /etc/nginx/sites-available/conf
COPY setup.sh setup.sh
EXPOSE 80/tcp
CMD ["/bin/sh", "./setup.sh"]
