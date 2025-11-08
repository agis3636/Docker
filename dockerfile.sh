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
