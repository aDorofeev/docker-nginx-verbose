FROM bitnami/minideb:stretch

RUN install_packages nginx nginx-extras

RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir -p /etc/nginx/sites-enabled && mkdir -p /etc/nginx/sites-available
RUM rm -f /etc/nginx/sites-enabled/*

ADD nginx.conf /etc/nginx/

# Detailed error pages
RUN mkdir /usr/share/nginx/html/nginx_error

ADD http_error_codes.sh /usr/local/bin
ADD make_error_inc.sh /usr/local/bin
ADD make_error_pages.sh /usr/local/bin
ADD docker_start_nginx.sh /usr/local/bin

RUN /usr/local/bin/make_error_inc.sh
RUN /usr/local/bin/make_error_pages.sh

RUN usermod -u 1000 www-data

CMD ["docker_start_nginx.sh"]

STOPSIGNAL SIGTERM

EXPOSE 80
