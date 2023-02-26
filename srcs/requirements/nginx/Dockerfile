FROM debian:buster

ARG DOMAIN
ARG WP_PATH

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install nginx

RUN apt-get -y update && apt-get -y install openssl

RUN useradd www
RUN usermod -a -G www www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www ${WP_PATH}

RUN mkdir -p /run/nginx

RUN mkdir -p /etc/nginx/ssl
WORKDIR /etc/nginx/ssl
RUN openssl req -x509 -out amarini-.crt -keyout amarini-.key -newkey rsa:2048 -nodes -sha256 -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=amarini-/CN=amarini-/distinguished_name=dn/subjectAltName=DNS:${DOMAIN}/keyUsage=digitalSignature/extendedKeyUsage=serverAuth"
RUN chmod 600 amarini-.crt
RUN chmod 600 amarini-.key

COPY nginx.conf /etc/nginx/sites-available/${DOMAIN}

RUN ln -s /etc/nginx/sites-available/${DOMAIN} /etc/nginx/sites-enabled

WORKDIR /

EXPOSE 443

ENTRYPOINT ["usr/sbin/nginx", "-g", "daemon off;"]