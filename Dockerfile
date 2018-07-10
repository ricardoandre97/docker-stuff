FROM alpine

RUN apk update && apk add nginx

RUN mkdir /run/nginx

COPY index.html /usr/share/nginx/html/index.html

COPY conf /etc/nginx/conf.d/default.conf

CMD nginx -g 'daemon off;'
