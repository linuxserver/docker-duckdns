[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

[![Blog](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Blog)](https://blog.linuxserver.io "all the things you can do with our containers including How-To guides, opinions and much more!")
[![Discord](https://img.shields.io/discord/354974912613449730.svg?style=flat-square&color=E68523&label=Discord&logo=discord&logoColor=FFFFFF)](https://discord.gg/YWrKVTn "realtime support / chat with the community and the team.")
[![Discourse](https://img.shields.io/discourse/https/discourse.linuxserver.io/topics.svg?style=flat-square&color=E68523&logo=discourse&logoColor=FFFFFF)](https://discourse.linuxserver.io "post on our community forum.")
[![Fleet](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Fleet)](https://fleet.linuxserver.io "an online web interface which displays all of our maintained images.")
[![GitHub](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=GitHub&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver "view the source for all of our repositories.")
[![Open Collective](https://img.shields.io/opencollective/all/linuxserver.svg?style=flat-square&color=E68523&label=Supporters&logo=open%20collective&logoColor=FFFFFF)](https://opencollective.com/linuxserver "please consider helping us by either donating or contributing to our budget")

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring:

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [Discourse](https://discourse.linuxserver.io) - post on our community forum.
* [Fleet](https://fleet.linuxserver.io) - an online web interface which displays all of our maintained images.
* [GitHub](https://github.com/linuxserver) - view the source for all of our repositories.
* [Open Collective](https://opencollective.com/linuxserver) - please consider helping us by either donating or contributing to our budget

# [linuxserver/duckdns](https://github.com/linuxserver/docker-duckdns)

[![GitHub Stars](https://img.shields.io/github/stars/linuxserver/docker-duckdns.svg?style=flat-square&color=E68523&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver/docker-duckdns)
[![GitHub Release](https://img.shields.io/github/release/linuxserver/docker-duckdns.svg?style=flat-square&color=E68523&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver/docker-duckdns/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=GitHub%20Package&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver/docker-duckdns/packages)
[![GitLab Container Registry](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=GitLab%20Registry&logo=gitlab&logoColor=FFFFFF)](https://gitlab.com/Linuxserver.io/docker-duckdns/container_registry)
[![Quay.io](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Quay.io)](https://quay.io/repository/linuxserver.io/duckdns)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/linuxserver/duckdns.svg?style=flat-square&color=E68523)](https://microbadger.com/images/linuxserver/duckdns "Get your own version badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/duckdns.svg?style=flat-square&color=E68523&label=pulls&logo=docker&logoColor=FFFFFF)](https://hub.docker.com/r/linuxserver/duckdns)
[![Docker Stars](https://img.shields.io/docker/stars/linuxserver/duckdns.svg?style=flat-square&color=E68523&label=stars&logo=docker&logoColor=FFFFFF)](https://hub.docker.com/r/linuxserver/duckdns)
[![Build Status](https://ci.linuxserver.io/view/all/job/Docker-Pipeline-Builders/job/docker-duckdns/job/master/badge/icon?style=flat-square)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-duckdns/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/duckdns/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/duckdns/latest/index.html)

[Duckdns](https://duckdns.org/) is a free service which will point a DNS (sub domains of duckdns.org) to an IP of your choice. The service is completely free, and doesn't require reactivation or forum posts to maintain its existence.

[![duckdns](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/duckdns.png)](https://duckdns.org/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `linuxserver/duckdns` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=duckdns \
  -e PUID=1000 `#optional` \
  -e PGID=1000 `#optional` \
  -e TZ=Europe/London \
  -e SUBDOMAINS=subdomain1,subdomain2 \
  -e TOKEN=token \
  -e LOG_FILE=false `#optional` \
  -v /path/to/appdata/config:/config `#optional` \
  --restart unless-stopped \
  linuxserver/duckdns
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2.1"
services:
  duckdns:
    image: linuxserver/duckdns
    container_name: duckdns
    environment:
      - PUID=1000 #optional
      - PGID=1000 #optional
      - TZ=Europe/London
      - SUBDOMAINS=subdomain1,subdomain2
      - TOKEN=token
      - LOG_FILE=false #optional
    volumes:
      - /path/to/appdata/config:/config #optional
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-e SUBDOMAINS=subdomain1,subdomain2` | multiple subdomains allowed, comma separated, no spaces |
| `-e TOKEN=token` | DuckDNS token |
| `-e LOG_FILE=false` | Set to `true` to log to file (also need to map /config). |
| `-v /config` | Used in conjunction with logging to file. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`. 

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

You only need to set the PUID and PGID variables if you are mounting the /config folder

&nbsp;
## Application Setup

- Go to the [duckdns website](https://duckdns.org/), register your subdomain(s) and retrieve your token
- Create a container with your subdomain(s) and token
- It will update your IP with the DuckDNS service every 5 minutes


## Docker Mods
[![Docker Mods](https://img.shields.io/badge/dynamic/yaml?style=for-the-badge&color=E68523&label=mods&query=%24.mods%5B%27duckdns%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=duckdns "view available mods for this container.")

We publish various [Docker Mods](https://github.com/linuxserver/docker-mods) to enable additional functionality within the containers. The list of Mods available for this image (if any) can be accessed via the dynamic badge above.


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
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull duckdns`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d duckdns`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once duckdns
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/linuxserver/docker-duckdns.git
cd docker-duckdns
docker build \
  --no-cache \
  --pull \
  -t linuxserver/duckdns:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **13.04.20:** - Add donation links for DuckDNS.
* **19.12.19:** - Rebasing to alpine 3.11.
* **24.09.19:** - Fix perms on github and remove chmod that can stall the container.
* **28.06.19:** - Rebasing to alpine 3.10.
* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **22.02.19:** - Rebasing to alpine 3.9.
* **08.02.19:** - Update readme with optional parameters.
* **10.12.18:** - Fix docker compose example.
* **15.10.18:** - Multi-arch image.
* **22.08.18:** - Rebase to alpine 3.8.
* **08.12.17:** - Rebase to alpine 3.7.
* **28.05.17:** - Rebase to alpine 3.6.
* **09.02.17:** - Rebase to alpine 3.5.
* **17.11.16:** - Initial release.
