#!/usr/bin/env bash

set -o errexit
set -o nounset

export CONTAINER_ID="$(hostname)"

SERVICE_NAME="$(echo ${SERVICE_NAME:-})"
NGINX_SERVER_NAME=""
if [ "${SERVICE_NAME}" != "" ]; then
    NGINX_SERVER_NAME="${SERVICE_NAME}"
else
    NGINX_SERVER_NAME="${CONTAINER_ID}"
fi
export NGINX_SERVER_NAME="${NGINX_SERVER_NAME}"

make-error-pages.sh
env-replace.sh /etc/nginx/proxy_params.nginx.tpl > /etc/nginx/proxy_params;
enable-sites.sh

exec nginx
