FROM alpine:3.17
LABEL maintainer "Takahiro INOUE <github.com/hinata>, The Oh Brothers <github.com/theohbrothers>"

ENV NGINX_VERSION 1.25.3

RUN set -eux; \
    apk add --no-cache openssl-dev pcre-dev zlib-dev; \
    apk add --no-cache alpine-sdk gettext apache2-utils; \
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

EXPOSE 3128

STOPSIGNAL SIGTERM

ENTRYPOINT [ "/docker-entrypoint.sh" ]
