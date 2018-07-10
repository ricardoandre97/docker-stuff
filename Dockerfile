FROM alpine

RUN apk update && apk add nginx

RUN mkdir /run/nginx

COPY index.html /usr/share/nginx/html/index.html

CMD nginx -g 'daemon off;'
