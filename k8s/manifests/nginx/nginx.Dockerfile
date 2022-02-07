FROM nginx

COPY default.conf /etc/nginx/conf.d/default.conf
COPY ./myssl.crt /etc/ssl/certs/myssl.crt
COPY ./myssl.key /etc/ssl/private/myssl.key

