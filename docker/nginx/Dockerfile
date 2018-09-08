FROM bitnami/minideb:stretch

RUN install_packages gnupg2 curl ca-certificates

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
RUN curl -s https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo 'deb http://nginx.org/packages/mainline/debian/ stretch nginx' >> '/etc/apt/sources.list.d/nginx.org.list' && \
    echo 'deb-src http://nginx.org/packages/mainline/debian/ stretch nginx' >> '/etc/apt/sources.list.d/nginx.org.list'

RUN install_packages nginx nginx-module-perl

RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir -p /etc/nginx/sites-enabled && mkdir -p /etc/nginx/sites-available
RUN rm -f /etc/nginx/sites-enabled/*

COPY nginx.conf /etc/nginx/

# Detailed error pages
RUN mkdir /usr/share/nginx/html/nginx_error

COPY http-error-codes.sh /usr/local/bin
COPY make-error-inc.sh /usr/local/bin
COPY make-error-pages.sh /usr/local/bin
COPY enable-sites.sh /usr/local/bin
COPY docker-entrypoint.sh /usr/local/bin
COPY env-replace.sh /usr/local/bin
COPY proxy_params.nginx /etc/nginx/proxy_params.nginx.tpl

RUN /usr/local/bin/make-error-inc.sh
RUN /usr/local/bin/make-error-pages.sh

RUN usermod -u 1000 www-data

ENTRYPOINT ["docker-entrypoint.sh"]

STOPSIGNAL SIGTERM

EXPOSE 80
