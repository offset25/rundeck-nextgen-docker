#!/bin/bash

read -p "Enter external server URL (e.g. http://rundeck.lan): " external_server_url


# if apt installed
if command -v apt &> /dev/null
then
	apt-get update -y
	apt-get install git -y
	apt-get install docker -y
	apt-get install docker-compose -y
fi

#if yum installed
if command -v yum &> /dev/null
then
	yum install git -y
	yum install docker -y
	yum install docker-compose -y
fi

git clone git@github.com:EugenMayer/docker-image-rundeck.git
yes | cp docker/config/docker-compose.yml docker-image-rundeck/
yes | cp docker/config/.env docker-image-rundeck/
yes | cp docker/nginx/rundeck.nginx.conf docker-image-rundeck/nginx/

if test -z "$external_server_url" 
then
      echo ""
else
	echo " is NOT empty"
	old='EXTERNAL_SERVER_URL=http://rundeck.lan'
	new="EXTERNAL_SERVER_URL=$external_server_url"

	sed -i -e 's,'"$old"','"$new"',g' docker-image-rundeck/.env
fi

cd docker-image-rundeck; docker-compose up -d
