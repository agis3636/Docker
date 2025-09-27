docker info
docker version

# ngambil image

docker images
docker pull mongo:4.1
docker images

# buat container

docker container ls
docker container ls --all
docker container create mongo:4.1
docker container create --name mongoserver1 mongo:4.1
docker container ls
docker container ls --all
docker container create --name mongoserver1 mongo:4.1 (ERROR)
docker container create --name mongoserver2 mongo:4.1
docker container ls --all

# jalankan container

docker container start mongoserver1
docker container ls
docker container start mongoserver2
docker container ls

# menghapus container

docker container rm mongoserver1
docker container ls
docker container stop mongoserver1
docker container stop mongoserver1 mongoserver2
docker container ls
docker container rm mongoserver1
docker container rm mongoserver1 mongoserver2
docker container ls --all
docker images

# membuka port untuk container

docker container create --name mongoserver1 -p 8080:27017 mongo:4.1
docker container create --name mongoserver2 -p 8181:27017 mongo:4.1
docker container ls --all
docker container start mongoserver1
docker container start mongoserver2
docker container ls

docker container stop mongoserver1

# menghapus image

docker images
docker images rm mongo:4.1 (ERROR, soalnya ada container jalan)
docker container stop mongoserver1
docker container stop mongoserver2
docker container rm mongoserver1
docker container rm mongoserver2
docker container ls
docker container ls --all
docker images rm mongo:4.1
