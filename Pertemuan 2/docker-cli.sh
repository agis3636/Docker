docker images ls
docker image pull redis:latest
docker images ls
coba diulang lagi nanti dia tidak akan download ulang
---
docker container create --name contohredis1 redis:latest
docker container start contohredis1
---
container log :

docker container logs contohredis1
docker container logs -f contohredis1
exit = ctrl+c
---
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

---

## container port, melakukan port forwarding dengan nginx + exec :

docker image pull nginx:latest
docker container create --name contohnginx1 --publish 8080:80 nginx:latest
docker container ls -a
docker container start contohnginx1
docker container ls -a
docker container stop contohnginx1
docker container ls -a

docker exec -it contohnginx1 /bin/bash
docker exec -it contohnginx1 /bin/sh
/usr/share/nginx/html

/usr/local/apache2/htdocs/

---

### docker container env :

docker image pull mongo:latest
docker container create --name contohmongo1 --publish 9999:27017 --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest

---

# docker container stats :

jalankan semua container sebanyak banyaknya
