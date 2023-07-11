# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.18

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CRON_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    logrotate \
    jq

# add local files
COPY root/ /
