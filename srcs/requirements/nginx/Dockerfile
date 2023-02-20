FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install nginx

# COPY nginx.conf /etc/nginx/sites-available/default

RUN apt-get -y update && apt-get -y install openssl

RUN useradd www
RUN usermod -a -G www www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /var/www

RUN mkdir -p /run/nginx

RUN mkdir -p /etc/nginx/ssl
WORKDIR /etc/nginx/ssl
RUN openssl req -x509 -out amarini-.crt -keyout amarini-.key -newkey rsa:2048 -nodes -sha256 -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=amarini-/CN=amarini-/distinguished_name=dn/subjectAltName=DNS:localhost/keyUsage=digitalSignature/extendedKeyUsage=serverAuth"
RUN chmod 600 amarini-.crt
RUN chmod 600 amarini-.key

# RUN mkdir -p /etc/ssl/certs/ && mkdir -p /etc/ssl/private/
# RUN openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=FR/ST=75/L=Paris/O=42Paris/OU=amarini-/CN=localhost" -keyout ssl-cert-snakeoil.key -out ssl-cert-snakeoil.pem
# RUN mv ssl-cert-snakeoil.pem /etc/ssl/certs/ && mv ssl-cert-snakeoil.key /etc/ssl/private/
# RUN cp /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/certs/
# RUN chmod 600 /etc/ssl/certs/ssl-cert-snakeoil.pem && chmod 600 /etc/ssl/private/ssl-cert-snakeoil.key

COPY nginx.conf /etc/nginx/sites-available/localhost

RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled

WORKDIR /

# COPY nginx.conf /etc/nginx/nginx.conf
# COPY nginx.conf /etc/nginx/conf.d/nginx.conf
# COPY nginx.conf /etc/nginx/sites-enabled/000-default.conf

EXPOSE 443
# EXPOSE 8080

ENTRYPOINT ["usr/sbin/nginx", "-g", "daemon off;"]