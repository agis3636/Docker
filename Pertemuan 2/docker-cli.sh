docker images ls
docker image pull redis:latest
docker images ls
coba diulang lagi nanti dia tidak akan download ulang

docker container create --name contohredis1 redis:latest
docker container start contohredis1

container log :
docker container logs contohredis1
docker container logs -f contohredis1
exit = ctrl+c

container exec :
