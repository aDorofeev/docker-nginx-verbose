#!/usr/bin/env bash

DIR=$(dirname $0)
source "$DIR/http_error_codes.sh"

NGINX_ERRORS_DIR="/usr/share/nginx/html/nginx_error"
NGINX_VERSION_STRING="$(nginx -v 2>&1)"
DOCKER_HOST_HOSTNAME="$(echo $DOCKER_HOST_HOSTNAME)"
CONTAINER_ID="$(hostname)"

mkdir -p "$NGINX_ERRORS_DIR"

for HTTP_CODE in "${!HTTP_CODE_LIST[@]}" ; do
    cat > "$NGINX_ERRORS_DIR/$HTTP_CODE.html" << HEREDOC
<html>
<head><title>$HTTP_CODE ${HTTP_CODE_LIST[$HTTP_CODE]}</title></head>
<body bgcolor="white">
<center><h1>$HTTP_CODE ${HTTP_CODE_LIST[$HTTP_CODE]}</h1></center>
<hr><center>$NGINX_VERSION_STRING CID $CONTAINER_ID on host $DOCKER_HOST_HOSTNAME</center>
</body>
</html>
<!-- a padding to disable MSIE and Chrome friendly error page -->
<!-- a padding to disable MSIE and Chrome friendly error page -->
<!-- a padding to disable MSIE and Chrome friendly error page -->
<!-- a padding to disable MSIE and Chrome friendly error page -->
<!-- a padding to disable MSIE and Chrome friendly error page -->
<!-- a padding to disable MSIE and Chrome friendly error page -->
HEREDOC
done

