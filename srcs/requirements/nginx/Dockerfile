FROM ubuntu
RUN apt-get -y update && apt-get -y install nginx
COPY conf /etc/nginx/sites-available/conf
EXPOSE 80/tcp
CMD ["/usr/sbin/nginx", "-g", "deamon off;"]
