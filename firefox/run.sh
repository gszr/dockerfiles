#!/bin/sh

IMAGE_NAME="gmesalazar/firefox"
X11_SOCKET="/tmp/.X11-unix"

# Build Firefox image if needed
if [[ -z $(docker images -q ${IMAGE_NAME}) ]]; then
  echo "Building Docker image ${IMAGE_NAME}"
  docker build -t ${IMAGE_NAME} .
fi

xhost local:root

docker run -ti --rm \
  -e DISPLAY=$DISPLAY \
  -v ${X11_SOCKET}:${X11_SOCKET} \
  ${IMAGE_NAME}
