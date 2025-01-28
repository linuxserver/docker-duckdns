# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DUCKDNS_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    bind-tools \
    logrotate && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version

# add local files
COPY root/ /
