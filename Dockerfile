FROM lsiobase/xenial
MAINTAINER sathed

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config" \
PYTHONIOENCODING=utf-8

# add get-pip.py for pip installation
COPY get-pip.py /get-pip/get-pip.py

# install packages
RUN \
 echo "deb http://ppa.launchpad.net/jcfp/nobetas/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 echo "deb-src http://ppa.launchpad.net/jcfp/nobetas/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 echo "deb http://ppa.launchpad.net/jcfp/sab-addons/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 echo "deb-src http://ppa.launchpad.net/jcfp/sab-addons/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:11371 --recv-keys 0x98703123E0F52B2BE16D586EF13930B14BB9F05F && \
 apt-get update && \
 apt-get install -y \
	p7zip-full \
	par2-tbb \
	python-sabyenc \
	sabnzbdplus \
	unrar \
	unzip && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN python /get-pip/get-pip.py && \
	pip install urllib3 chardet certifi pyopenssl

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080 9090
VOLUME /config /downloads /incomplete-downloads