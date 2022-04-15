#!/usr/bin/with-contenv bash

. /app/duck.conf
RESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=")
if [ "${RESPONSE}" = "OK" ]; then
    echo "Your IP was updated at $(date)"
else
    echo -e "Something went wrong, please check your settings $(date)\nThe response returned was:\n${RESPONSE}"
fi
