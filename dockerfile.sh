# FROM INSTRUCTION
buat file Dockerfile ke dalam directory
  FROM alpine:3

build docker di terminal
  docker build -t agis3636/namaimages directory
  docker build -t agis3636/from from
  docker image ls
  docker images

------------------------------------------------------------

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

------------------------------------------------------------------

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

  # COPY INSTRUCTION
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
