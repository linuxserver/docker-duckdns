[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/duckdns](https://github.com/linuxserver/docker-duckdns)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/duckdns.svg)](https://microbadger.com/images/linuxserver/duckdns "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/duckdns.svg)](https://microbadger.com/images/linuxserver/duckdns "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/duckdns.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/duckdns.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-duckdns/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-duckdns/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/duckdns/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/duckdns/latest/index.html)

[Duckdns](https://duckdns.org/) is a free service which will point a DNS (sub domains of duckdns.org) to an IP of your choice. The service is completely free, and doesn't require reactivation or forum posts to maintain its existence.

[![duckdns](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/duckdns.png)](https://duckdns.org/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

Simply pulling `linuxserver/duckdns` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=duckdns \
  -e PUID=1001 `#optional` \
  -e PGID=1001 `#optional` \
  -e TZ=Europe/London \
  -e SUBDOMAINS=subdomain1,subdomain2 \
  -e TOKEN=token \
  -e LOG_FILE=false `#optional` \
  -v </path/to/appdata/config>:/config `#optional` \
  --restart unless-stopped \
  linuxserver/duckdns
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  duckdns:
    image: linuxserver/duckdns
    container_name: duckdns
    environment:
      - PUID=1001 #optional
      - PGID=1001 #optional
      - TZ=Europe/London
      - SUBDOMAINS=subdomain1,subdomain2
      - TOKEN=token
      - LOG_FILE=false #optional
    volumes:
      - </path/to/appdata/config>:/config #optional
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-e SUBDOMAINS=subdomain1,subdomain2` | multiple subdomains allowed, comma separated, no spaces |
| `-e TOKEN=token` | DuckDNS token |
| `-e LOG_FILE=false` | Set to `true` to log to file (also need to map /config). |
| `-v /config` | Used in conjunction with logging to file. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

You only need to set the PUID and PGID variables if you are mounting the /config folder

&nbsp;
## Application Setup

- Go to the [duckdns website](https://duckdns.org/), register your subdomain(s) and retrieve your token
- Create a container with your subdomain(s) and token
- It will update your IP with the DuckDNS service every 5 minutes



## Support Info

* Shell access whilst the container is running: `docker exec -it duckdns /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f duckdns`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' duckdns`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/duckdns`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/duckdns`
* Stop the running container: `docker stop duckdns`
* Delete the container: `docker rm duckdns`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start duckdns`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/duckdns`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **08.02.19:** - Update readme with optional parameters.
* **10.12.18:** - Fix docker compose example.
* **15.10.18:** - Multi-arch image.
* **22.08.18:** - Rebase to alpine 3.8.
* **08.12.17:** - Rebase to alpine 3.7.
* **28.05.17:** - Rebase to alpine 3.6.
* **09.02.17:** - Rebase to alpine 3.5.
* **17.11.16:** - Initial release.
