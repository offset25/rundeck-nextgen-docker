#rundeck installation procedure
must have git installed
must have docker installed
must have docker-compose installed

this will only work on linux distributions

will automatically try to install git or docker

this repo works on top of EugenMayer/docker-image-rundeck.git repo

# install instructions
sh init-rundeck-docker.sh

will setup docker and run docker-compose

you can access via http://hostname:port/

it takes a few minutes for it to start


to start run inside the docker-image-rundeck folder:
docker-compose up -d

to restart run inside the docker-image-rundeck folder:
docker-compose restart

to stop run inside the docker-image-rundeck folder:
docker-compose down


SSL Support
I added some ssl support. You can copy your certificate to docker-image-rundeck/nginx/cert
and overwrite cert1.pem and privkey1.pem
you then need to restart your docker setup
docker-compose restart
make sure to specify https in your external_server_url

rundeck doesn't seem to fully support ssl on non-standard ports. May need to add http to https redirect and further ssl support
