#rundeck installation procedure
must have git installed
must have docker installed
must have docker-compose installed

this will only work on linux distributions

will automatically try to install git or docker

# install instructions
sh init-rundeck-docker.sh

will setup docker and run docker-compose

you can access via http://<hostname>/

it takes a few minutes for it to start


for some reason rundeck will only run on standard ports. The redirects it does for login doesn't include port if using non standard port.

to start run:
docker-compose up -d

to restart run:
docker-compose restart

to stop run:
docker-compose down
