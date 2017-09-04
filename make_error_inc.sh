#!/usr/bin/env bash

DIR=$(dirname $0)
source "$DIR/http_error_codes.sh"

INC_FILE_PATH="/etc/nginx/detailed_errors.conf.inc"

echo > "$INC_FILE_PATH"
for HTTP_CODE in "${!HTTP_CODE_LIST[@]}" ; do
    echo "error_page $HTTP_CODE /nginx_error/$HTTP_CODE.html;" >> "$INC_FILE_PATH"
done

cat >> "$INC_FILE_PATH" << HEREDOC

location /nginx_error {
    internal;
    root /usr/share/nginx/html;
}

HEREDOC
