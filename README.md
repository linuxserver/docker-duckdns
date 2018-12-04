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

[Duckdns](https://duckdns.org/) is a free service which will point a DNS (sub domains of duckdns.org) to an IP of your choice. The service is completely free, and doesn't require reactivation or forum posts to maintain its existence.

[![duckdns](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/duckdns.png)](https://duckdns.org/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

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
  -e TZ=Europe/London \
  -e SUBDOMAINS=subdomain1,subdomain2 \
  -e TOKEN=token \
  --restart unless-stopped \
  linuxserver/duckdns
```

### optional parameters
`-e LOG_FILE=true` if you prefer the duckdns log to be written to a file instead of the docker log  
`-v <path to data>:/config` used in conjunction with logging to file

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  duckdns:
    image: linuxserver/duckdns
    container_name: duckdns
      - TZ=Europe/London
      - SUBDOMAINS=subdomain1,subdomain2
      - TOKEN=token
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-e SUBDOMAINS=subdomain1,subdomain2` | multiple subdomains allowed, comma separated, no spaces |
| `-e TOKEN=token` | DuckDNS token |


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

## Versions

* **15.10.18:** - Multi-arch image.
* **22.08.18:** - Rebase to alpine 3.8.
* **08.12.17:** - Rebase to alpine 3.7.
* **28.05.17:** - Rebase to alpine 3.6.
* **09.02.17:** - Rebase to alpine 3.5.
* **17.11.16:** - Initial release.
