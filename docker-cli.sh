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
    root@343535252 > ls
    root@343535252 > cd /
    root@343535252 > ls
    root@343535252 > redis-cli
      127.0.0.1:6379 > set name "Hello World!!!"
      127.0.0.1:6379 > get name
      127.0.0.1:6379 > exit
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
    
    /usr/local/apache2/htdocs/

---

# Docker Container ENV :

  docker image pull mongo:latest
  docker container create --name contohmongo1 --publish 9999:27017 --env MONGO_INITDB_ROOT_USERNAME=agis --env MONGO_INITDB_ROOT_PASSWORD=agis mongo:latest

---

# Docker Container STATS :

jalankan semua container sebanyak banyaknya
  docker container stats

---

# Docker Container Resource Limit (memory | cpu) :

  docker container create --name smallnginx --publish 8080:80 --memory 100m --cpus 0.5 nginx:latest
  docker container ls -a
  docker container start smallnginx
  docker container stats
