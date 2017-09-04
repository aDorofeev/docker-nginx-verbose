FROM nginx

RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir /etc/nginx/sites-enabled && mkdir /etc/nginx/sites-available

ADD nginx.conf /etc/nginx/

# Detailed error pages
RUN mkdir /usr/share/nginx/html/nginx_error

ADD http_error_codes.sh /usr/local/bin
ADD make_error_inc.sh /usr/local/bin
ADD make_error_pages.sh /usr/local/bin

RUN /usr/local/bin/make_error_inc.sh
RUN /usr/local/bin/make_error_pages.sh

RUN usermod -u 1000 nginx
#RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

CMD ["nginx"]

EXPOSE 80
