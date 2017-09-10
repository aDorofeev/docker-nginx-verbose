#!/usr/bin/env bash

/usr/local/bin/make_error_pages.sh

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$CHILD_NGINX_PID"
}

trap _term SIGTERM

echo "Starging nginx...";
nginx -g "daemon off" &

CHILD_NGINX_PID=$!
wait "$CHILD_NGINX_PID"
echo "Nginx terminated."
