#!/bin/sh
set -eu

RESOLVER=${RESOLVER:-8.8.8.8}
HTTP_PASSWD=${HTTP_PASSWD:-}
if [ -n "$RESOLVER" ] || [ -n "$LISTTEN_PORT" ] ; then
    echo "Applying: resolver $RESOLVER;"
    echo "System is listening on port $LISTTEN_PORT;"
    echo "Configuration httppasswd is locating at /usr/local/nginx/conf/httppasswd"
    envsubst < /tmp/nginx.conf.template > /usr/local/nginx/conf/nginx.conf

    if [[ ! -n "${HTTP_PASSWD}" ]]; then
      echo "HTTP_PASSWD is not exist"
      sed -i '29,30d;' /usr/local/nginx/conf/nginx.conf 
    else
      echo "HTTP_PASSWD is already set"
      envsubst < /tmp/httppasswd.template > /usr/local/nginx/conf/httppasswd
    fi

    nginx -g 'daemon off;'
fi

if [ $# -gt 0 ] && [ "${1#-}" != "$1" ]; then
    set -- nginx "$@"
fi

exec "$@"