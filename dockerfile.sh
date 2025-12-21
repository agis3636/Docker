# FROM INSTRUCTION
buat file Dockerfile ke dalam directory
  FROM alpine:3

build docker di terminal
  docker build -t agis3636/namaimages directory
  docker build -t agis3636/from from
  docker image ls
  docker images

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

# RUN INSTRUCTION
edit file Dockerfile di dalam directory
  FROM alpine:3

  RUN mkdir hello
  RUN echo "hello world" > "hello/world.txt"
  RUN cat "hello/world.txt"

build docker di terminal
  docker build -t agis3636/run run

build dengan progress dan no cache
  docker image rm namaimage
  
  docker build -t agis3636/run run --progress=plain --no-cache
  docker image ls
  docker image ls | grep agis3636

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # CMD INSTRUCTION
edit file Dockerfile di dalam directory
  FROM alpine:3

  RUN mkdir hello
  RUN echo "hello world" > "hello/world.txt"
  
  CMD cat "hello/world.txt"

build docker di terminal
  docker build -t agis3636/command command

inspect
  docker image inspect namaimage
  docker image inspect agis3636/command
  
  docker container create --name command agis3636/command
  docker container start command
  docker container ls (ga ada karna dia otomatis mati)
  docker container ls -a | grep command
  docker container logs command
  
coba start 3 x lalu liat logs nya psti di logs sesuai dengan apa yang di start

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # LABEL INSTRUCTION
edit file Dockerfile di dalam directory
  FROM alpine:3

  LABEL author="Muhamad Agis"
  LABEL company="PT.Maju Mundur Tersakiti" website="https://archtech.my.id"

  RUN mkdir hello
  RUN echo "hello world" > "hello/world.txt"
  
  CMD cat "hello/world.txt"
  
build docker di terminal
  docker build -t agis3636/command command

inspect
  docker image inspect namaimage
  docker image inspect agis3636/command

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # ADD INSTRUCTION
buat directory add dan di dalam nya ada Dockerfile
lalu buat directory text di dalam directory add
buat agis.txt areta.txt dll sampai banyak
  ---------------
  FROM alpine:3

  RUN mkdir hello
  ADD text/agis.txt hello
  ADD text/areta.txt hello
  ADD text/agis.txt hello
  ADD text/areta.txt hello

  CMD cat "/hello/agis.txt"
  ---------------
  FROM alpine:3

  RUN mkdir hello
  ADD text/*.txt hello

  CMD cat "/hello/agis.txt"
  ---------------
build docker di terminal
  docker build -t agis3636/command command

  docker container create --name command agis3636/command
  docker container start command
  docker container logs command

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # COPY INSTRUCTION
buat directory add dan di dalam nya ada Dockerfile
lalu buat directory text di dalam directory add
buat agis.txt areta.txt dll sampai banyak
  ---------------
  FROM alpine:3

  RUN mkdir hello
  COPY text/*.txt hello

  CMD cat "/hello/areta.txt"
  ---------------
build docker di terminal
  docker build -t agis3636/command command

  docker container create --name command agis3636/command
  docker container start command
  docker container logs command

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # DOCKERIGNORE File
buat directory ignore dan di dalam nya ada Dockerfile dan .dockerignore dan directory text
lalu didalam text ada app.log, sample.log, world.txt, directory temp
di dalam temp ada sample.txt

edit .dockerignore=
  ---------------
  text/*.log
  text/temp
  
edit Dockerfile=
  ---------------
  FROM alpine:3

  RUN mkdir hello
  COPY text/* hello

  CMD ls -l hello
  ---------------
build docker di terminal
  docker build -t agis3636/command command

  docker container create --name command agis3636/command
  docker container start command
  docker container logs command

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # EXPOSE INSTRUCTION
buat directory expose | didalamnya ada file coding golang bernama main.go | sejajar dengan .Dockerfile
file main.go ada di pertemuan 8 "main-go-expose"
  
edit Dockerfile=
  ---------------
  FROM golang:1.18-alpine

  RUN mkdir app
  COPY main.go app

  EXPOSE 8080

  CMD go run app/main.go
  ---------------
build docker di terminal
  docker build -t agis3636/command command

  docker image inspect agis3636/command (ada informasi expose)
  docker container create --name command -p 8080:8080 agis3636/command
  docker container start command
  docker container ls
buka browser (ipaddress:8080) | atau bisa juga menggunakan perintah curl
  curl localhost:8080
  docker container stop command
  curl localhost:8080 (maka dia mati)
  docker container ls (ga ada container / mati)

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # ENVIRONMENT VARIABLE INSTRUCTION
buat directory env | didalamnya ada file coding golang bernama main.go | sejajar dengan .Dockerfile
file main.go ada di pertemuan 8 "main-go-env"
  
edit Dockerfile=
  ---------------
  FROM golang:1.18-alpine
  
  ENV APP_PORT=8080

  RUN mkdir app
  COPY main.go app

  EXPOSE ${APP_PORT}

  CMD go run app/main.go
  ---------------
build docker di terminal
  docker build -t agis3636/command command

  docker image inspect agis3636/command (ada informasi env)
  docker container create --name command --env APP_PORT=9090 -p 9090:9090 agis3636/command
  docker container start command

  docker container ls
  docker container logs command
  
buka browser (ipaddress:9090) | atau bisa juga menggunakan perintah curl
  curl localhost:8080 (coba pakai port 8080 dulu, pasti dia ga akan jalan)
  curl localhost:9090 (dia jalan)
  
  docker container stop command
  curl localhost:9090 (maka dia mati)
  docker container ls (ga ada container / mati)

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # VOLUME INSTRUCTION
buat directory volume | didalamnya ada file coding golang bernama main.go | sejajar dengan .Dockerfile
file main.go ada di pertemuan 8 "main-go-volume"
  
edit Dockerfile=
  ---------------
  FROM golang:1.18-alpine
  
  ENV APP_PORT=8080
  ENV APP_DATA=/logs

  RUN mkdir ${APP_DATA}
  RUN mkdir app
  COPY main.go app

  EXPOSE ${APP_PORT}
  VOLUME ${APP_DATA}

  CMD go run app/main.go
  ---------------
build docker di terminal
  docker build -t agis3636/command command

  docker image inspect agis3636/command (ada informasi volume)
  docker container create --name command -p 8080:8080 agis3636/command
  docker container start command

  docker container logs command (cuma nampilin logs run di por 8080 aja)
buka http://localhost:9090/budi
buka http://localhost:9090/enda
buka http://localhost:9090/suli
nanti dia akan otomatis buat file di logs
  docker container logs command (semua nya di tampilin)

  docker container inspect command (cari nama volume di mounts)
96ca3f052e608b4c3d479cd30d71047d9f33d1e4cac661bedde500c6fe8c34d2

  docker volume ls
pastikan nama volume yang dicek pada saat inspect ada

matikan
  docker container stop command

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

  # WORKDIR INSTRUCTION
buat directory workdir | didalamnya ada file coding golang bernama main.go | sejajar dengan .Dockerfile
file main.go ada di pertemuan 8 "main-go-expose"
  
edit Dockerfile=
  ---------------
  FROM golang:1.18-alpine

  WORKDIR /app
  COPY main.go /app
  
  EXPOSE 8080

  CMD go run main.go
  ---------------
build docker di terminal
  docker build -t agis3636/command command
  docker container create --name command -p 8080:8080 agis3636/command
  docker container start command

  docker container exec -i -t command /bin/sh
