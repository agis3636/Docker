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
docker container exec -i -t contohredis1 /bin/bash
root@343535252 > ls
root@343535252 > cd /
root@343535252 > ls
root@343535252 > redis-cli
127.0.0.1:6379 > set name "Hello World!!!"
127.0.0.1:6379 > get name
127.0.0.1:6379 > exit
root@343535252 > exit
