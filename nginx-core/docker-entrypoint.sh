#!/bin/sh
set -eu

RESOLVER=${RESOLVER:-8.8.8.8}
if [ -n "$RESOLVER" ]; then
    echo "Applying: resolver $RESOLVER;"
    touch /usr/local/nginx/conf/httppasswd
    envsubst < /tmp/nginx.conf.template > /usr/local/nginx/conf/nginx.conf
    envsubst < /tmp/httppasswd.template > /usr/local/nginx/conf/httppasswd
    nginx -g 'daemon off;'
fi

if [ $# -gt 0 ] && [ "${1#-}" != "$1" ]; then
    set -- nginx "$@"
fi

exec "$@"