FROM debian

RUN apt-get -y update && apt-get -y install nginx
RUN mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/sites-available/nginx.conf
EXPOSE 443/tcp

CMD ["usr/sbin/nginx", "-g", "daemon off;"]
