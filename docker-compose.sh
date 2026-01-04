# Docker Compose

---

buat file dengan nama "docker-compose.yaml"

    services:
      nginx-example:
        container_name: nginx-example
        image: nginx:latest

---

untuk menjalankan Container, harus masuk ke dalam directory yang menyimpan file "docker-compose.yaml"

    docker compose create
