#!/bin/sh
set -eu

RESOLVER=${RESOLVER:-8.8.8.8}
if [ -n "$RESOLVER" ] && [ -n "$LISTTEN_PORT" ] && [ -n "$HTTP_PASSWD" ]; then
    echo "Applying: resolver $RESOLVER;"
    echo "System is listening on port $LISTTEN_PORT;"
    echo "Configuration httppasswd is locating at /usr/local/nginx/conf/httppasswd"

    touch /usr/local/nginx/conf/httppasswd
    envsubst < /tmp/nginx.conf.template > /usr/local/nginx/conf/nginx.conf
    envsubst < /tmp/httppasswd.template > /usr/local/nginx/conf/httppasswd
    nginx -g 'daemon off;'
fi

if [ $# -gt 0 ] && [ "${1#-}" != "$1" ]; then
    set -- nginx "$@"
fi

exec "$@"