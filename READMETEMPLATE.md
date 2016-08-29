![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring auto-update on startup, easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/index.php/category/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/duckdns

Duck DNS is a free service which will point a DNS (sub domains of duckdns.org) to an IP of your choice. The service is completely free, and doesn't require reactivation or forum posts to maintain its existence.

## Usage

```
docker create \
  --name=DuckDNS \
  -e PGID=<gid> -e PUID=<uid>  \
  -e SUBDOMAINS=<subdomains> \
  -e TOKEN=<token> \
  linuxserver/duckdns
```

**Parameters**

* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e SUBDOMAINS` for subdomains - multiple subdomains allowed, comma separated, no spaces
* `-e TOKEN` for DuckDNS token


### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

First, go to www.duckdns.org, register your subdomain and retrieve your token  
Then run the docker create command above with your subdomain(s) and token  
It will update your IP with the DuckDNS service every 5 minutes  


## Updates

* Shell access whilst the container is running: `docker exec -it DuckDNS /bin/bash`
* Upgrade to the latest version: `docker restart DuckDNS`
* To monitor the logs of the container in realtime: `docker logs -f DuckDNS`

## Versions

+ **25.03.2016:** Initial release
