#!/bin/bash

read -p "Enter external server URL without the port (default is set to http://rundeck.lan): " external_server_url
read -p "Enter external server port (default is set to 80): " external_server_port
read -p "Enter external server ssl port (default is set to 443): " external_server_ssl_port
read -p "Enter admin password (default is set to: \"rundeck\"): " rundeck_admin_password


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
	#echo " is NOT empty"
	old='EXTERNAL_SERVER_URL=http://rundeck.lan'
	new="EXTERNAL_SERVER_URL=$external_server_url"

	sed -i -e 's,'"$old"','"$new"',g' docker-image-rundeck/.env
fi

if test -z "$external_server_port" 
then
      echo ""
else
	#echo " is NOT empty"
	old='EXTERNAL_SERVER_PORT=80'
	new="EXTERNAL_SERVER_PORT=$external_server_port"

	sed -i -e 's,'"$old"','"$new"',g' docker-image-rundeck/.env
fi

if test -z "$external_server_ssl_port" 
then
      echo ""
else
	#echo " is NOT empty"
	old='EXTERNAL_SERVER_SSL_PORT=443'
	new="EXTERNAL_SERVER_SSL_PORT=$external_server_ssl_port"

	sed -i -e 's,'"$old"','"$new"',g' docker-image-rundeck/.env
fi

if test -z "$rundeck_admin_password" 
then
      echo ""
else
	#echo " is NOT empty"
	old='RUNDECK_ADMIN_PASSWORD=rundeck'
	new="RUNDECK_ADMIN_PASSWORD=$rundeck_admin_password"

	sed -i -e 's,'"$old"','"$new"',g' docker-image-rundeck/.env
fi

#ssl copy sample ssl
cp -R docker/sample-cert docker-image-rundeck/nginx/cert

cd docker-image-rundeck; docker-compose up -d
