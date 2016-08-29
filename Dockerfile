FROM lsiobase/alpine
MAINTAINER aptalca

# environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# install packages
RUN \
 apk add --no-cache \
	curl

# add local files
COPY root/ /
