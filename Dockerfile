# set base os
FROM lsiobase/python:3.11

RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home

RUN \
 echo "**** install system packages ****" && \
 apk add --no-cache \
	git \
	nodejs && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	comictagger==1.1.32rc1 \
	configparser \
	html5lib \
	requests \
	tzlocal && \
 echo "**** install app ****" && \
 git clone https://github.com/evilhero/mylar.git -b development /app/mylar && \
 cd /app/mylar && \
 echo "**** cleanup ****" && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /comics /downloads
EXPOSE 8090

# Copy out the auto processing scripts to the config directory
RUN \
	cp /app/mylar/*.csv /config/
