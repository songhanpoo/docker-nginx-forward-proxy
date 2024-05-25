ARG ALPINE_VERSION=3.17
ARG NGINX_VERSION_ARG=1.25.3

FROM alpine:${ALPINE_VERSION}
LABEL maintainer "Songhanpoo <github.com/songhanpoo>"

ENV NGINX_VERSION=${NGINX_VERSION_ARG}

RUN set -eux; \
    apk add --no-cache openssl-dev pcre-dev zlib-dev; \
    apk add --no-cache alpine-sdk gettext; \
    \
    cd /tmp; \
    wget -q https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz; \
    tar -xvf nginx-$NGINX_VERSION.tar.gz; \
    cd nginx-$NGINX_VERSION; \
    \
    git clone https://github.com/chobits/ngx_http_proxy_connect_module; \
    \
    patch -p1 < ./ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch; \
    ./configure \
      --add-module=./ngx_http_proxy_connect_module \
      --sbin-path=/usr/sbin/nginx \
      --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC'; \
    make -j $(nproc); \
    make install; \
    apk add --no-cache openssl-dev pcre-dev zlib-dev; \
    nginx -v; \
    \
    rm -rf /tmp/*; \
    apk del alpine-sdk

COPY ./httppasswd.template /tmp/httppasswd.template
COPY ./nginx.conf.template /tmp/nginx.conf.template
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

STOPSIGNAL SIGTERM

ENTRYPOINT [ "/docker-entrypoint.sh" ]
