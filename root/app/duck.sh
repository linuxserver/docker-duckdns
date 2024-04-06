#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [[ "${LOG_FILE,,}" = "true" ]]; then
    DUCK_LOG="/config/duck.log"
    touch "${DUCK_LOG}"
    touch /config/logrotate.status
    /usr/sbin/logrotate -s /config/logrotate.status /app/logrotate.conf
else
    DUCK_LOG="/dev/null"
fi

{
    # Use cloudflare to autodetect IP if UPDATE_IP is set
    if [[ "${UPDATE_IP}" = "ipv4" ]]; then
        echo "Detecting IPv4 via CloudFlare"
        IPV4=$(dig +short ch txt whoami.cloudflare -4 @1.1.1.1 | sed 's/"//g')
        DRESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=${IPV4}&verbose=true")
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    elif [[ "${UPDATE_IP}" = "ipv6" ]]; then
        echo "Detecting IPv6 via CloudFlare"
        IPV6=$(dig +short ch txt whoami.cloudflare -6 @2606:4700:4700::1111 | sed 's/"//g')
        DRESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ipv6=${IPV6}&verbose=true")
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    elif [[ "${UPDATE_IP}" = "both" ]]; then
        echo "Detecting IPv4 and IPv6 via CloudFlare"
        IPV4=$(dig +short ch txt whoami.cloudflare -4 @1.1.1.1 | sed 's/"//g')
        IPV6=$(dig +short ch txt whoami.cloudflare -6 @2606:4700:4700::1111 | sed 's/"//g')
        DRESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=${IPV4}&ipv6=${IPV6}&verbose=true")
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    else
    # Use DuckDns to autodetect IPv4 (default behaviour)
        echo "Detecting IPv4 via DuckDNS"
        DRESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=&verbose=true")
        IPV4=$(echo "${DRESPONSE}" | awk 'NR==2')
        IPV6=$(echo "${DRESPONSE}" | awk 'NR==3')
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    fi

    if [[ "${RESPONSE}" = "OK" ]] && [[ "${IPCHANGE}" = "UPDATED" ]]; then
        if [[ "${IPV4}" != "" ]] && [[ "${IPV6}" == "" ]]; then
            echo "Your IP was updated at $(date) to IPv4: ${IPV4}"
        elif [[ "${IPV4}" == "" ]] && [[ "${IPV6}" != "" ]]; then
            echo "Your IP was updated at $(date) to IPv6: ${IPV6}"
        else
            echo "Your IP was updated at $(date) to IPv4: ${IPV4} & IPv6 to: {$IPV6}" 
        fi
    elif [[ "${RESPONSE}" = "OK" ]] && [[ "${IPCHANGE}" = "NOCHANGE" ]]; then
        echo "DuckDNS request at $(date) successful. IP(s) unchanged."
    else
        echo -e "Something went wrong, please check your settings $(date)\nThe response returned was:\n${DRESPONSE}\n"
    fi
} | tee -a "${DUCK_LOG}"
