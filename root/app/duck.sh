#!/usr/bin/with-contenv bash

. /app/duck.conf
RESPONSE=$(curl -sSk "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=")
if [ "${RESPONSE}" = "OK" ]; then
    echo "$(date): Your IP was updated"
else
    echo -e "$(date): Something went wrong, please check your settings.\nThe response returned was:\n${RESPONSE}"
fi

if [ -n "${PRIVATE_SUBDOMAINS}" ]; then
    PRIVATE_IP=$(ip -4 route get 8.8.8.8 2>/dev/null | awk {'print $7'} | tr -d '\n')
    if [ -n "$PRIVATE_IP" ]; then
        RESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${PRIVATE_SUBDOMAINS}&token=${TOKEN}&ip=${PRIVATE_IP}")
        if [ "${RESPONSE}" = "OK" ]; then
            echo "$(date): Your private IP was updated to ${PRIVATE_IP}"
        else
            echo -e "$(date): Something went wrong updating your private IP to ${PRIVATE_IP}, please check your settings\nThe response returned was:\n${RESPONSE}"
        fi
    else
        echo "$(date): No assigned private IP found"
    fi
fi
