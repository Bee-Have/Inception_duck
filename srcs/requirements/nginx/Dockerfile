FROM debian:buster

RUN apt-get -y update && apt-get -y install nginx

COPY nginx.conf /etc/nginx/sites-available/default

RUN apt-get -y update && apt-get -y install openssl
RUN mkdir -p /run/nginx
RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=FR/ST=75/L=Paris/O=42Paris/OU=amarini/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
RUN mkdir -p etc/ssl/certs/ && mkdir -p /etc/ssl/private/
RUN mv localhost.dev.crt etc/ssl/certs/ && mv localhost.dev.key /etc/ssl/private/
RUN chmod 600 /etc/ssl/certs/localhost.dev.crt && chmod 600 /etc/ssl/private/localhost.dev.key

EXPOSE 443

ENTRYPOINT ["usr/sbin/nginx", "-g", "daemon off;"]