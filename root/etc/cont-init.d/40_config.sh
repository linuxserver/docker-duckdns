#!/usr/bin/with-contenv bash

  #Check to make sure the subdomain and token are set
if [ -z "$SUBDOMAINS" ] || [ -z "$TOKEN" ]; then
  echo "Please pass both your subdomain(s) and token as environment variables in your docker run command. See docker info for more details."
  exit 1
else
  echo "Retrieving subdomain and token from the environment variables"
  echo -e "SUBDOMAINS=$SUBDOMAINS TOKEN=$TOKEN" > /app/duck.conf
fi

# set crontab
crontab -u abc /defaults/duckcron

# permissions
chown -R abc:abc \
	/app
chmod +x /app/duck.sh

# run initial IP update
exec \
	s6-setuidgid abc /app/duck.sh
