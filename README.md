[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: http://www.duckdns.org/
[hub]: https://hub.docker.com/r/linuxserver/duckdns/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/duckdns
[![](https://images.microbadger.com/badges/version/linuxserver/duckdns.svg)](https://microbadger.com/images/linuxserver/duckdns "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/duckdns.svg)](https://microbadger.com/images/linuxserver/duckdns "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/duckdns.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/duckdns.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-duckdns)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-duckdns/)

Duck DNS is a free service which will point a DNS (sub domains of duckdns.org) to an IP of your choice. The service is completely free, and doesn't require reactivation or forum posts to maintain its existence.

[![duckdns](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/duckdns.png)][appurl]

## Usage

```
docker create \
  --name=duckdns \
  -e PGID=<gid> -e PUID=<uid>  \
  -e SUBDOMAINS=<subdomains> \
  -e TOKEN=<token> \
  -e TZ=<timezone> \
  linuxserver/duckdns
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e SUBDOMAINS` for subdomains - multiple subdomains allowed, comma separated, no spaces
* `-e TOKEN` for DuckDNS token
* `-e TZ` for timezone information, eg Europe/London
* optional `-e LOG_FILE=true` if you prefer the duckdns log to be written to a file instead of the docker log
* optional `-v <path to data>:/config` used in conjunction with logging to file


### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

First, go to [duckdns site][appurl], register your subdomain and retrieve your token  
Then run the docker create command above with your subdomain(s) and token  
It will update your IP with the DuckDNS service every 5 minutes  

If you'd like the output in a file, set the optional parameter LOG_FILE to true and map a volume for /config  


## Info

* Shell access whilst the container is running: `docker exec -it duckdns /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f duckdns`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' duckdns`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/duckdns`

## Versions

+ **28.05.2017:** Rebase to alpine 3.6.
+ **09.02.2017:** Rebase to alpine 3.5.
+ **17.11.2016:** Initial release
