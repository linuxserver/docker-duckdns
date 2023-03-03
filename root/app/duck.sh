#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [ "${LOG_FILE}" = "true" ]; then
    LOG_FILE="/config/duck.log"
    touch "${LOG_FILE}"
    /usr/sbin/logrotate /app/logrotate.conf
else
    LOG_FILE="/dev/null"
fi

{
    RESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=")
    if [ "${RESPONSE}" = "OK" ]; then
        echo "Your IP was updated at $(date)"
    else
        echo -e "Something went wrong, please check your settings $(date)\nThe response returned was:\n${RESPONSE}"
    fi
} | tee -a "${LOG_FILE}"
