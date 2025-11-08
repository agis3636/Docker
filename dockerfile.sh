# FROM INSTRUCTION
buat file Dockerfile ke dalam directory
  FROM alpine:3

build docker di terminal
  docker build -t agis3636/namaimages directory
  docker build -t agis3636/from from
  docker image ls
  docker images

# RUN INSTRUCTION
edit file Dockerfile di dalam directory
  FROM alpine:3

  RUN mkdir hello
  Run echo "hello world" > "hello/world.txt"
  RUN cat "hello/world.txt"

build docker di terminal
  docker build -t agis3636/run run
  docker build -t agis3636/run run --progress=plain --no-cache
  docker image ls | grep agis3636

  # CMD INSTRUCTION
edit file Dockerfile di dalam directory
  FROM alpine:3

  RUN mkdir hello
  Run echo "hello world" > "hello/world.txt"
  
  CMD cat "hello/world.txt"

build docker di terminal
  docker build -t agis3636/command command
  docker image inspect agis3636/command
  docker container create --name command agis3636/command
  docker container start command
  docker container ls -a | grep command
  docker container logs command
  
