FROM ubuntu:14.04

ARG UID=1000
ARG GID=1000

RUN \
	apt-get update && apt-get install -y firefox

RUN \
	mkdir -p /home/browser && \
	echo "browser:x:${UID}:${GID}:Browser,,,:/home/browser:/bin/bash" >> /etc/passwd && \
	echo "browser:x:${UID}:" >> /etc/group && \
	chown ${UID}:${GID} -R /home/browser

USER browser
ENV home /home/browser

CMD /usr/bin/firefox
