# Docker Image

  docker images ls
  docker image pull redis:latest
  docker images ls
coba diulang lagi nanti dia tidak akan download ulang

---

# Docker Container

  docker container create --name contohredis1 redis:latest
  docker container start contohredis1

---

# Docker Container LOG :

  docker container logs contohredis1
  docker container logs -f contohredis1
  exit = ctrl+c

---

# Docker Container EXEC :

  docker container exec -i -t contohredis1 /bin/bash
    root@343535252:/data# ls
    root@343535252:/data# cd /
    root@343535252:/# ls
    root@343535252:/# redis-cli
      127.0.0.1:6379> set name "Hello World!!!"
      127.0.0.1:6379> get name
      127.0.0.1:6379> exit
    root@343535252 > exit

---

# Docker Container PORT, melakukan port forwarding dengan nginx + exec :

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

TUGAS RUNNING DOCKER PORT FORWARDING + EXEC DENGAN APACHE !!!
    /usr/local/apache2/htdocs/

---

# Docker Container ENV :

  docker image pull mongo:latest
  docker container create --name contohmongo1 --publish 9999:27017 --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest
connect ke mongodb client

---

# Docker Container STATS :

jalankan semua container sebanyak banyaknya
  docker container stats

---

# Docker Container Resource Limit (MEMORY | CPUS) :

  docker container create --name smallnginx --publish 8080:80 --memory 100m --cpus 0.5 nginx:latest
  docker container ls -a
  docker container start smallnginx
  docker container stats

---

# Docker Container BIND NOUNTS :

  docker image pull mongo:latest
buat dulu directory untuk simpan data di host/pc. directory ini di gunakan untuk source
  docker container create --name mongodata --mount "type=bind,source=/direktory-di-pc,destination=/data/db" --publish 9999:27017 --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest

selanjutnya buka directory di laptop, dan data dari docker container akan ada di laptop

  docker container ls
  docker container start moongodata
  docker container ls
  
connect ke mongodb client
buat database dan tabel di mongodb client


berikutnya coba stop dan delete container
maka datanya akan tetap aman di laptop

buat lagi container dengan environtment yang sama
  docker container create --name mongodata --mount "type=bind,source=/directory-di-pc,destination=/data/db" --publish 9999:27017 --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest
cek ke mongodb client dan data akan tetap ada

---

# Docker VOLUME :

  docker volume ls
  docker volume create mongovolume
  docker volume ls
  docker volume rm mongovolume

  docker container create --name mongodatavolume --mount "type=volume,source=mongovolume,destination=/data/db" --publish 8888:27017 --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest
  docker container start mongodatavolume

connect ke mongodb client

  docker container stop mongodatavolume
  docker container rm mongodatavolume

# Docker VOLUME BACKUP manual :

  docker container stop mongodatavolume
buat dulu directory baru buat backup. directory ini di buat untuk source
  docker container create --name nginxbackup --mount "type=bind,source=/directory-baru,destination=/backup" --mount "type=volume,source=mongovolume,destination=/data" nginx:latest
  docker container start nginxbackup
  docker container exec -i -t nginxbackup /bin/bash
    root@e96282473126:/# ls -lah
    root@e96282473126:/# cd /data/
    root@e96282473126:/data# ls -lah
    root@e96282473126:/data# cd /backup/
    root@e96282473126:/backup# ls -lah
    root@e96282473126:/backup# tar cvf /backup/backupdata.tar.gz /data/
    root@e96282473126:/backup# ls
    root@e96282473126:/backup# exit
  docker container stop nginxbackup 
  docker container rm nginxbackup 
  docker container start mongodatavolume

# Docker VOLUME BACKUP otomatis :

stop dulu container mongonya
  docker container run --rm --name ubuntubackup --mount "type=bind,source=/directory-baru,destination=/backup" --mount "type=volume,source=mongovolume,destination=/data" ubuntu:latest tar cvf /backup/backupdata2.tar.gz /data/
kalo udah selesai cek containernya. ada ga container ubuntu? pasti hilang

# Docker NETWORK :

  docker network ls
  docker network create --driver namadriver namanetwork
  docker network ls
  docker network rm namanetwork

# Docker Container NETWORK :

  docker network create --driver namadriver namanetwork
  docker network ls
  
  docker container create --name namacontainer --network mongonetwork image:tag
  docker container create --name contohmongodb --network mongonetwork --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest
  docker pull mongo-express:latest
  docker container create --name contohmongoexpress --network mongonetwork --publish 8081:8081 --env ME_CONFIG_MONGODB_URL="mongodb://agis:agis@namacontainer:27017/" mongo-express:latest
  docker container start contohmongodb
  docker container start contohmongoexpress

Dan kalau kamu pengin skip login, tambahkan di atas:

"  --env ME_CONFIG_BASICAUTH=false "

# Menghapus/disconnect Container dari NETWORK :

  docker network disconnect namanetwork namacontainer
coba hapus container contohmongodb dari network mongonetwork

cek log
  docker container logs namacontainer

# Menambahkan/connect Container dari NETWORK :

  docker network connect namanetwork namacontainer

