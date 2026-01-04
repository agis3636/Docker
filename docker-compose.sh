# Docker Compose

---

                BUAT FILE DOCKER COMPOSE

buat file dengan nama "docker-compose.yaml"

    services:
      nginx-example:
        container_name: nginx-example
        image: nginx:latest

---

                MEMBUAT CONTAINER
                
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

                JALANKAN CONTAINER

    docker compose start
    docker container ls

---

                MELIHAT CONTAINER

jalankan dulu container yang dibuat selain menggunakan compose

    docker compose ps
    docker compose ls

---

                MENGHENTIKAN CONTAINER

    docker compose stop

ini hanya menghentikan container yang di setting dari compose saja, yang bukan dari compose ga mati

---

                MENGHAPUS CONTAINER

coba di start dulu composenya. karna bedanya kalo kita pakai docker compose, ketika di hapus composenya dia bisa langsung terhapus tanpa harus di matikan dulu compose nya

    docker compose start
    docker compose down
    docker compose ps -a
    docker container ls -a
