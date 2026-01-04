# Docker Compose

---

buat file dengan nama "docker-compose.yaml"

    services:
      nginx-example:
        container_name: nginx-example
        image: nginx:latest

---

untuk membuat Container, harus masuk ke dalam directory yang menyimpan file "docker-compose.yaml"

    docker compose create
    docker container ls -a

---

mau bikin lagi ?

    services:
        nginx-example:
            container_name: nginx-example
            image: nginx:latest
        nginx-example2:
            container_name: nginx-example2
            image: nginx:latest

---

untuk membuat Container, harus masuk ke dalam directory yang menyimpan file "docker-compose.yaml"

    docker compose create
    docker container ls -a

---

jalankan container

    docker compose start
    docker container ls
