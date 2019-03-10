# set base os
FROM lsiobase/alpine.python:3.9

# Set correct environment variables
ENV HOME /root

# Configure user nobody to match unRAID's settings
RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home

# set version label
ARG BUILD_DATE
ARG VERSION
ARG MYLAR_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="xthursdayx"

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
RUN chown -R nobody:users \
	/app
	/config

# Add mylar to runit
RUN mkdir /etc/service/mylar
ADD mylar.sh /etc/service/mylar/run
RUN chmod +x /etc/service/mylar/run
