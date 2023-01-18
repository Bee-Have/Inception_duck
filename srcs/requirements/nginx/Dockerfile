FROM debian
RUN apt-get -y update && apt-get -y install nginx
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/http.d/default.conf
COPY setup.sh setup.sh
EXPOSE 8080/tcp
CMD ["/bin/sh", "./setup.sh"]
