## 1️⃣ Bedanya **Dockerfile** vs **Docker Compose**

### 🔹 Dockerfile

**Fungsi:**
Untuk **build image**.

**Fokus:**
Isi *1 container* → environment di dalamnya.

**Dipakai saat:**

* Mau bikin image custom
* Nentuin base image, install package, copy file, set CMD/ENTRYPOINT

**Contoh alur:**

```
Dockerfile → docker build → IMAGE → docker run → CONTAINER
```

**Contoh Dockerfile singkat:**

```dockerfile
FROM nginx:alpine
COPY ./html /usr/share/nginx/html
EXPOSE 80
```

➡️ Artinya: bikin image nginx dengan konten sendiri.

---

### 🔹 Docker Compose (`docker-compose.yml`)

**Fungsi:**
Untuk **menjalankan & mengatur banyak container sekaligus**.

**Fokus:**
Relasi antar container:

* service
* network
* volume
* environment
* dependency (`depends_on`)

**Dipakai saat:**

* App butuh banyak service (web + db + redis + dll)
* Mau 1 command buat naik/turun semua container

**Contoh alur:**

```
Dockerfile (optional)
↓
docker-compose.yml
↓
docker compose up
↓
BANYAK CONTAINER JALAN BARENG
```

**Contoh Compose:**

```yaml
services:
  web:
    build: .
    ports:
      - "80:80"

  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
```

➡️ `web` dan `db` jalan bareng + otomatis satu network.

---

### 🧠 Ringkasnya

| Aspek         | Dockerfile     | Docker Compose        |
| ------------- | -------------- | --------------------- |
| Tujuan        | Build image    | Orchestrate container |
| Skala         | 1 container    | Banyak container      |
| Output        | Image          | Running services      |
| Command utama | `docker build` | `docker compose up`   |

➡️ **Dockerfile = resep**
➡️ **Docker Compose = menu restoran lengkap**
