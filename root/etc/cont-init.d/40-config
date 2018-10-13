#!/usr/bin/with-contenv bash

  #Check to make sure the subdomain and token are set
if [ -z "$SUBDOMAINS" ] || [ -z "$TOKEN" ]; then
  echo "Please pass both your subdomain(s) and token as environment variables in your docker run command. See docker info for more details."
  exit 1
else
  echo "Retrieving subdomain and token from the environment variables"
  echo -e "SUBDOMAINS=$SUBDOMAINS TOKEN=$TOKEN" > /app/duck.conf
fi

# modify crontab if logging to file
if [ "$LOG_FILE" = "true" ]; then
  crontab -u abc /defaults/duckcron
  echo "log will be output to file"
else
  echo "log will be output to docker log"
fi

# permissions
chown -R abc:abc \
	/app \
	/config
chmod +x /app/duck.sh

# run initial IP update
exec \
	s6-setuidgid abc /app/duck.sh
