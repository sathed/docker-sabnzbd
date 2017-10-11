## Notes

This is a fork of the [docker-sabnzbd repo](https://github.com/linuxserver/docker-sabnzbd) from [LinuxServer.io](https://linuxserver.io/). There are minor differences, which you can see in the Dockerfile.

Added:

```
pip
  - urllib3
  - chardet
  - certifi
  - pyopenssl
```

These changes were added simply to help with my own personal integrations with Slack.

## Usage

```
docker create --name=sabnzbd \
-v <path to data>:/config \
-v <path to downloads>:/downloads \
-v <path to incomplete downloads>:/incomplete-downloads \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 8080:8080 -p 9090:9090 \
linuxserver/sabnzbd
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.


* `-p 8080` - http port for the webui
* `-p 9090` - https port for the webui *see note below*
* `-v /config` - local path for sabnzbd config files
* `-v /downloads` local path for finished downloads
* `-v /incomplete-downloads` local path for incomplete-downloads - *optional*
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 
Initial setup is done from the http port.
Https access for sabnzbd needs to be enabled in either the intial setup wizard or in the configure settings of the webui, be sure to use 9090 as port for https.
See here for info on some of the switch settings for sabnzbd http://wiki.sabnzbd.org/configure-switches


## Info

* Shell access whilst the container is running: `docker exec -it sabnzbd /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f sabnzbd`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' sabnzbd`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sabnzbd`
