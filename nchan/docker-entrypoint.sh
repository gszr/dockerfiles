#!/bin/sh

APP_PATH=/app

mkdir ${APP_PATH}
mkdir ${APP_PATH}/logs

exec openresty -g "daemon off;" -p "${APP_PATH}" \
  -c "${APP_PATH}/conf/nginx.conf"
