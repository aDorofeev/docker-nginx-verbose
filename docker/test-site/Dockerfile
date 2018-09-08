FROM adorofeev/nginx-verbose:devel

COPY test-site.nginx /etc/nginx/sites-available/test-site.nginx.tpl

CMD ["make-nginx-conf.sh"]