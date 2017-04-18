#
# OpenResty Dockerfile
#

FROM alpine:latest

MAINTAINER Guilherme Salazar <gmesalazar@gmail.com>

ARG RESTY_V="1.11.2.2"
ARG RESTY_SSL_V="2.4.5"
ARG RESTY_PCRE_V="8.40"
ARG RESTY_MODS=""
ARG RESTY_J="8"
ARG ROCKS_V="2.4.2"
ARG ROCKS=""

ARG RESTY_HOME="/usr/local/openresty"
ENV PATH="${PATH}:${RESTY_HOME}/bin:${RESTY_HOME}/nginx/sbin"
ENV PATH="${PATH}:${RESTY_HOME}/luajit/bin"

RUN \
	mkdir /tmp/resty_build_area \
	&& cd /tmp/resty_build_area \
	#
	# 1) Install build and runtime dependencies
	#
	&& apk add --no-cache --virtual .build \
		build-base \
		perl-dev \
		zlib-dev \
		linux-headers \
		ca-certificates \
	&& apk add --no-cache \
		libgcc \
		zlib \
		wget \
	#
	# 2) Download OpenResty, *SSL, PCRE, and LuaRocks
	#
	&& wget https://openresty.org/download/openresty-${RESTY_V}.tar.gz \
	&& wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${RESTY_SSL_V}.tar.gz \
	&& wget https://ftp.pcre.org/pub/pcre/pcre-${RESTY_PCRE_V}.tar.gz \
	&& wget https://luarocks.org/releases/luarocks-${ROCKS_V}.tar.gz \
	&& tar -xf openresty-${RESTY_V}.tar.gz \
	&& tar -xf libressl-${RESTY_SSL_V}.tar.gz \
	&& tar -xf pcre-${RESTY_PCRE_V}.tar.gz \
	&& tar -xf luarocks-${ROCKS_V}.tar.gz \
	#
	# 3) Build OpenResty
	#
	&& cd openresty-${RESTY_V} \
	&& ./configure -j${RESTY_J} ${RESTY_MODS} \
		--with-openssl=/tmp/resty_build_area/libressl-${RESTY_SSL_V} \
		--with-pcre=/tmp/resty_build_area/pcre-${RESTY_PCRE_V} \
	&& make -j${RESTY_J} install \
	&& cd ../ \
	#
	# 4) Build LuaRocks
	#
	&& cd luarocks-${ROCKS_V} \
	&& ./configure \
		--prefix=/usr/local/openresty/luajit \
		--with-lua=/usr/local/openresty/luajit \
		--lua-suffix=jit-2.1.0-beta2 \
		--with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
	&& make build && make install \
	#
	# 5) Install Rocks
	#
	&& cd ../ \
	&& for rock in ${ROCKS}; do \
		luarocks install ${rock}; \
	done \
	#
	# 6) Cleanup
	#
	&& rm -rf /tmp/resty_build_area \
	&& apk del .build

COPY docker-entrypoint.sh /

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
