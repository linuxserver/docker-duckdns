#!/usr/bin/with-contenv bash

. /app/duck.conf
RESPONSE=`curl -s "https://www.duckdns.org/update?domains=$SUBDOMAINS&token=$TOKEN&ip="`
if [ "$RESPONSE" = "OK" ]; then
echo "Your IP was updated at "$(date)
else
echo "Something went wrong, please check your settings  "$(date)
fi
