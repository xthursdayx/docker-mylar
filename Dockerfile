# set base os
FROM lsiobase/alpine.python:3.9

RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home

# set version label
ARG BUILD_DATE
ARG VERSION
ARG MYLAR_COMMIT

RUN \
 echo "**** install system packages ****" && \
 apk add --no-cache \
	git \
	nodejs && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	comictagger \
	configparser \
	html5lib \
	tzlocal && \
 echo "**** install app ****" && \
 if [ -z ${MYLAR_COMMIT+x} ]; then \
	MYLAR_COMMIT=$(curl -sX GET https://api.github.com/repos/evilhero/mylar/commits/development \
	| awk '/sha/{print $4;exit}' FS='[""]'); \
 fi && \
 git clone https://github.com/evilhero/mylar.git -b development /app/mylar && \
 cd /app/mylar && \
 git checkout ${MYLAR_COMMIT} && \
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
	cp -R /app/mylar/post-processing/ /config/ && \
	cp /app/mylar/*.csv /config/
	
#change ownership on app
RUN \
	chown -R nobody:users /app && \
	chown -R nobody:users /config &&\
	/sbin/setuser nobody python /app/mylar/Mylar.py --datadir=/config
