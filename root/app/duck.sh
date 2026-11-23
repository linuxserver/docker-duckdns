#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [[ "${LOG_FILE,,}" = "true" ]]; then
    DUCK_LOG="/config/duck.log"
    touch "${DUCK_LOG}"
    touch /config/logrotate.status
    chmod 640 /config/logrotate.status
    /usr/sbin/logrotate -s /config/logrotate.status /config/logrotate.conf
else
    DUCK_LOG="/dev/null"
fi

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

{
    # Use ipify.org to autodetect IP if UPDATE_IP is set
    if [[ "${UPDATE_IP}" = "ipv4" ]]; then
        IPV4=$(curl -4 -sS --max-time 10 https://api.ipify.org 2>/dev/null | tr -d '[:space:]')
        if [[ -z "${IPV4}" ]]; then
            log "ERROR: Could not detect IPv4 address (api.ipify.org unreachable?)"
        else
            log "Detected IPv4: ${IPV4}"
        fi
        log "Calling DuckDNS update API..."
        DRESPONSE=$(curl -sS --max-time 60 -G \
            --data-urlencode "domains=${SUBDOMAINS}" \
            --data-urlencode "token=${TOKEN}" \
            --data-urlencode "ip=${IPV4}" \
            --data-urlencode "verbose=true" \
            "https://www.duckdns.org/update")
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    elif [[ "${UPDATE_IP}" = "ipv6" ]]; then
        IPV6=$(curl -6 -sS --max-time 10 https://api6.ipify.org 2>/dev/null | tr -d '[:space:]')
        # strict validation: only hex digits and colons, at least one colon required
        if [[ ! "${IPV6}" =~ ^[0-9a-fA-F:]+$ ]] || [[ "${IPV6}" != *:* ]]; then
            log "ERROR: Could not detect a valid IPv6 address (no IPv6 connectivity?)"
            IPV6=""
        else
            log "Detected IPv6: ${IPV6}"
        fi
        log "Calling DuckDNS update API..."
        DRESPONSE=$(curl -sS --max-time 60 -G \
            --data-urlencode "domains=${SUBDOMAINS}" \
            --data-urlencode "token=${TOKEN}" \
            --data-urlencode "ipv6=${IPV6}" \
            --data-urlencode "verbose=true" \
            "https://www.duckdns.org/update")
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    elif [[ "${UPDATE_IP}" = "both" ]]; then
        IPV4=$(curl -4 -sS --max-time 10 https://api.ipify.org 2>/dev/null | tr -d '[:space:]')
        if [[ -z "${IPV4}" ]]; then
            log "ERROR: Could not detect IPv4 address (api.ipify.org unreachable?)"
        else
            log "Detected IPv4: ${IPV4}"
        fi
        IPV6=$(curl -6 -sS --max-time 10 https://api6.ipify.org 2>/dev/null | tr -d '[:space:]')
        # strict validation: only hex digits and colons, at least one colon required
        if [[ ! "${IPV6}" =~ ^[0-9a-fA-F:]+$ ]] || [[ "${IPV6}" != *:* ]]; then
            log "WARNING: Could not detect a valid IPv6 address (no IPv6 connectivity?), updating IPv4 only"
            IPV6=""
        else
            log "Detected IPv6: ${IPV6}"
        fi
        log "Calling DuckDNS update API..."
        DRESPONSE=$(curl -sS --max-time 60 -G \
            --data-urlencode "domains=${SUBDOMAINS}" \
            --data-urlencode "token=${TOKEN}" \
            --data-urlencode "ip=${IPV4}" \
            --data-urlencode "ipv6=${IPV6}" \
            --data-urlencode "verbose=true" \
            "https://www.duckdns.org/update")
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    else
        # Use DuckDns to autodetect IPv4 (default behaviour)
        log "Calling DuckDNS update API (IPv4 detection via DuckDNS)..."
        DRESPONSE=$(curl -sS --max-time 60 "https://www.duckdns.org/update?domains=${SUBDOMAINS}&token=${TOKEN}&ip=&verbose=true")
        IPV4=$(echo "${DRESPONSE}" | awk 'NR==2')
        IPV6=$(echo "${DRESPONSE}" | awk 'NR==3')
        RESPONSE=$(echo "${DRESPONSE}" | awk 'NR==1')
        IPCHANGE=$(echo "${DRESPONSE}" | awk 'NR==4')
    fi

    if [[ "${RESPONSE}" = "OK" ]] && [[ "${IPCHANGE}" = "UPDATED" ]]; then
        if [[ -n "${IPV4}" ]] && [[ -z "${IPV6}" ]]; then
            log "SUCCESS: DuckDNS updated. IPv4: ${IPV4}"
        elif [[ -z "${IPV4}" ]] && [[ -n "${IPV6}" ]]; then
            log "SUCCESS: DuckDNS updated. IPv6: ${IPV6}"
        else
            log "SUCCESS: DuckDNS updated. IPv4: ${IPV4}, IPv6: ${IPV6}"
        fi
    elif [[ "${RESPONSE}" = "OK" ]] && [[ "${IPCHANGE}" = "NOCHANGE" ]]; then
        if [[ -n "${IPV4}" ]] && [[ -z "${IPV6}" ]]; then
            log "OK: IP unchanged. IPv4: ${IPV4}"
        elif [[ -z "${IPV4}" ]] && [[ -n "${IPV6}" ]]; then
            log "OK: IP unchanged. IPv6: ${IPV6}"
        else
            log "OK: IP unchanged. IPv4: ${IPV4}, IPv6: ${IPV6}"
        fi
    else
        log "ERROR: DuckDNS update failed. API response: ${DRESPONSE}"
    fi
} | tee -a "${DUCK_LOG}"
