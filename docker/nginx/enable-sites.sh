#!/usr/bin/env bash

set -o errexit
set -o nounset

find /etc/nginx/sites-available/ -name '*.nginx.tpl' | \
  xargs -i bash -c \
    'OUTPUT=$(echo "{}" | grep -oP "^.+(?=\.tpl)"); env-replace.sh "{}" > "${OUTPUT}"'

find /etc/nginx/sites-available/ -name '*.nginx' | \
  xargs -i bash -c \
    'FILENAME=$(basename {}); cd /etc/nginx/sites-enabled; rm -f "${FILENAME}"; ln -s "../sites-available/${FILENAME}" "${FILENAME}"'

exec nginx
