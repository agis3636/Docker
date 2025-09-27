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
