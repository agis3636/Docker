## 🧩 1. Apa itu **ENV**?

`ENV` (environment variable) = variabel lingkungan yang dipakai sistem atau aplikasi **buat nyimpen konfigurasi sementara**.

Contoh sederhananya kayak:

```
USERNAME=agis
PORT=8080
DEBUG=true
```

Variabel-variabel ini bisa dipakai oleh aplikasi biar:

* Gak perlu ubah kode tiap kali deploy
* Aman buat nyimpen rahasia (kayak password, token)
* Mudah dikonfigurasi ulang di environment berbeda (dev, staging, production)

## 🐳 2. Fungsi ENV di **Docker**

Di Docker, `ENV` dipakai buat **ngatur konfigurasi container**, **ngasih nilai ke aplikasi di dalam container**, dan **membuat image lebih fleksibel**.

Ada **3 cara umum** environment variable dipakai di Docker:

### ✅ **A. Di dalam Dockerfile**

Gunakan `ENV` langsung:

```Dockerfile
FROM ubuntu:latest
ENV APP_PORT=8080
ENV DEBUG=true

CMD echo "App jalan di port $APP_PORT"
```

Kalau container dijalankan dari image itu, otomatis dia punya variabel `APP_PORT=8080`.

### ✅ **B. Saat jalankan container (`docker run -e`)**

Lu bisa override atau nambah variabel waktu run:

```bash
docker run -e APP_PORT=3000 -e MODE=dev myimage
```

Artinya container itu punya:

```
APP_PORT=3000
MODE=dev
```

> Ini **tidak butuh akun** sama sekali. Semua container lokal bisa pakai ENV.

### ✅ **C. Lewat file `.env`**

Biasanya dipakai bareng `docker-compose.yml`, biar gak nulis banyak `-e`.

📁 **.env**

```
APP_PORT=8080
DATABASE_URL=mongodb://localhost:27017
```

📄 **docker-compose.yml**

```yaml
services:
  web:
    image: myapp
    env_file:
      - .env
    ports:
      - "${APP_PORT}:80"
```

Waktu `docker-compose up`, otomatis nilai dari `.env` dibaca dan dipakai.

## ⚙️ 3. Apa aja yang **pakai ENV di Docker**

Hampir **semua layer** di Docker bisa pakai ENV:

| Komponen                                      | Contoh Penggunaan                                              |
| --------------------------------------------- | -------------------------------------------------------------- |
| **Dockerfile**                                | Set default konfigurasi (PORT, PATH, API_KEY)                  |
| **docker run**                                | Set variabel runtime                                           |
| **docker-compose.yml**                        | Konfigurasi environment untuk service tertentu                 |
| **Aplikasi di container**                     | Baca variabel pakai kode (misal `process.env.PORT` di Node.js) |
| **Secret management (Vault, Swarm, Compose)** | Simpan credential lewat ENV atau file                          |

## 🧠 4. `ENV` bisa dipakai buat **konfigurasi internal container apa pun** — contohnya:

| Kasus              | Variabel ENV Umum                                          |
| ------------------ | ---------------------------------------------------------- |
| Web server (Nginx) | `NGINX_PORT`, `NGINX_HOST`                                 |
| Database (MongoDB) | `MONGO_INITDB_ROOT_USERNAME`, `MONGO_INITDB_ROOT_PASSWORD` |
| Node.js app        | `PORT`, `NODE_ENV`, `DB_URL`                               |
| PHP / Laravel      | `APP_ENV`, `DB_PASSWORD`, `CACHE_DRIVER`                   |
| Python Flask       | `FLASK_ENV`, `DATABASE_URI`                                |

## 📦 5. Contoh nyata pakai ENV di Docker Compose

Misal lu mau bikin MongoDB container:

📁 `.env`

```
MONGO_INITDB_ROOT_USERNAME=agis
MONGO_INITDB_ROOT_PASSWORD=12345
MONGO_PORT=27017
```

📄 `docker-compose.yml`

```yaml
services:
  mongodb:
    image: mongo:latest
    container_name: contohmongo
    ports:
      - "${MONGO_PORT}:27017"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=${MONGO_INITDB_ROOT_USERNAME}
      - MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD}
```

Kalau lu `docker-compose up -d`,
container langsung auto-config pakai ENV itu — tanpa hardcode di file YAML-nya.

## 🧾 Kesimpulan

| Pertanyaan             | Jawaban                                                   |
| ---------------------- | --------------------------------------------------------- |
| Apa itu ENV?           | Variabel lingkungan buat konfigurasi aplikasi/container   |
| Siapa yang bisa pakai? | Semua container, gak perlu akun                           |
| Di mana dipakai?       | Dockerfile, docker run, docker-compose, atau di dalam app |
| Gunanya apa?           | Biar konfigurasi fleksibel tanpa ubah kode                |
| Contoh umum            | PORT, DB_URL, USERNAME, PASSWORD, API_KEY                 |

