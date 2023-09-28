FROM nginx:1.25
RUN openssl dhparam -out /etc/nginx/dhparam.pem 4096
COPY nginx.conf ssl-params.conf /etc/nginx/
COPY wp.conf /etc/nginx/conf.d/default.conf