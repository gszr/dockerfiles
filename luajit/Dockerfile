#
# Lua + LuaRocks
#

FROM alpine:latest

MAINTAINER Guilherme Salazar <gmesalazar@gmail.com>

RUN \
	mkdir build && cd build && \
	apk add --no-cache \
		wget \
		unzip \
		openssl \
		build-base \
		openssl-dev \
		ca-certificates && \
	wget http://luajit.org/download/LuaJIT-2.1.0-beta2.tar.gz && \
	tar -xf LuaJIT-2.1.0-beta2.tar.gz && cd LuaJIT-2.1.0-beta2 && \
	make -j8 && make install && cd .. && \
	ln -s luajit-2.1.0-beta2 /usr/local/bin/luajit && \
	wget https://luarocks.org/releases/luarocks-2.4.2.tar.gz && \
	tar -xf luarocks-2.4.2.tar.gz && cd luarocks-2.4.2 && \
	./configure \
		--with-lua-include=/usr/local/include/luajit-2.1 \
		--lua-suffix=jit && \
	make build && make install && cd .. && \
	rm -rf build

ENTRYPOINT ["sh"]
