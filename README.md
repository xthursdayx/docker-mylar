Modified version of linuxserver Mylar docker. 

# [linuxserver/mylar](https://github.com/linuxserver/docker-mylar)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/mylar.svg)](https://microbadger.com/images/linuxserver/mylar "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/mylar.svg)](https://microbadger.com/images/linuxserver/mylar "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/mylar.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/mylar.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-mylar/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-mylar/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/mylar/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/mylar/latest/index.html)

[Mylar](https://github.com/evilhero/mylar) is an automated Comic Book downloader (cbr/cbz) for use with SABnzbd, NZBGet and torrents.

[![mylar](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/mylar-icon.png)](https://github.com/evilhero/mylar)

### docker

```
docker create \
  --name=mylar \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 8090:8090 \
  -v <path to data>:/config \
  -v <comics-folder>:/comics \
  -v <downloads-folder>:/downloads \
  --restart unless-stopped \
  linuxserver/mylar
```
