# Setelah Selesai Install Docker

## 🔹 `docker info`

👉 Dipakai untuk menampilkan **informasi lengkap** tentang instalasi Docker di sistem kamu.
Isinya termasuk:

* **Versi Docker Engine** yang sedang jalan
* **Jumlah container** (running, stopped, paused)
* **Jumlah image** yang tersimpan
* **Storage driver** (mis. overlay2, aufs, btrfs, dll)
* **Logging driver**
* **Cgroup driver**
* **Kernel version** & OS host
* **Registry default** (biasanya Docker Hub)
* **Swarm mode** (aktif atau tidak)
* **Resource limit** (CPU, memory, dll, kalau ada batasan)

📝 Singkatnya → `docker info` = **status & konfigurasi sistem Docker**.

Contoh output singkat :

```
Containers: 3
 Running: 1
 Paused: 0
 Stopped: 2
Images: 5
Server Version: 24.0.7
Storage Driver: overlay2
Cgroup Driver: cgroupfs
Kernel Version: 5.15.0-97-generic
Operating System: Ubuntu 22.04.3 LTS
Architecture: x86_64
```

---

## 🔹 `docker version`

👉 Dipakai untuk menampilkan **versi client & server** Docker.

Kenapa ada dua?

* **Client** = CLI (perintah `docker ...`) yang kamu jalankan di terminal.
* **Server** = daemon (dockerd) yang ngejalanin container.

Kadang, versi client & server bisa **beda** (misalnya client lebih baru, server masih lama).
Makanya ini penting buat debugging kalau ada error kompatibilitas.

Contoh output singkat:

```
Client:
 Version:           24.0.7
 API version:       1.43
 Go version:        go1.20.10
 Git commit:        afdd53b
 OS/Arch:           linux/amd64

Server: Docker Engine - Community
 Engine:
  Version:          24.0.7
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.10
  Git commit:       afdd53b
  OS/Arch:          linux/amd64
  Experimental:     false
```

📝 Singkatnya → `docker version` = **cek versi client & server (engine)**.

---

# Mengambil Image Docker

---

## 🔹 `docker images`

👉 Fungsinya: **menampilkan daftar image lokal** (yang sudah ada di mesin kamu).
Informasi yang ditampilkan biasanya:

* **REPOSITORY** → nama image (contoh: `mongo`, `nginx`, `ubuntu`)
* **TAG** → versi image (contoh: `4.1`, `latest`, `20.04`)
* **IMAGE ID** → hash unik image
* **CREATED** → kapan image dibuat (oleh pembuat image, bukan kapan kamu download)
* **SIZE** → ukuran image

Contoh output awal (mungkin kosong kalau belum pernah pull image):

```
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
```

---

## 🔹 `docker pull mongo:4.1`

👉 Fungsinya: **download image dari Docker registry (default: Docker Hub)** ke lokal.

Detail prosesnya:

* `mongo` = nama repository image → artinya kita ambil official image MongoDB.
* `:4.1` = tag image → versi 4.1. Kalau tidak ditulis, defaultnya `:latest`.
* Docker akan cek ke registry → download layer-layer image (layer bisa dibagi & dipakai ulang dengan image lain).
* Setelah selesai, image tersimpan di lokal.

Contoh output (disederhanakan):

```
4.1: Pulling from library/mongo
Digest: sha256:0a1c1a3d85...
Status: Downloaded newer image for mongo:4.1
docker.io/library/mongo:4.1
```

---

## 🔹 `docker images` (lagi setelah pull)

👉 Sekarang, kalau kamu jalankan lagi, harusnya image `mongo:4.1` sudah ada di daftar.

Contoh output:

```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
mongo        4.1       9c7a54a9a43c   3 years ago    361MB
```

---

# Membuat Container

---

## 🔹 `docker container ls`

👉 Alias: `docker ps`

* Menampilkan **container yang sedang berjalan** saja.
* Kalau output kosong → artinya belum ada container jalan.

Contoh output (awal, kosong):

```
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

---

## 🔹 `docker container ls --all`

👉 Alias: `docker ps -a`

* Menampilkan **SEMUA container** di sistem, baik yang sedang jalan maupun sudah berhenti (exited).
* Jadi bisa lihat history container yang pernah dibuat.

---

## 🔹 `docker container create mongo:4.1`

👉 Membuat container baru dari image `mongo:4.1`, **tanpa langsung menjalankannya**.

* Container punya ID unik.
* Status awal = `Created`.
* Karena tidak pakai `--name`, maka Docker otomatis kasih nama random (misalnya `vigorous_wilson`).

---

## 🔹 `docker container create --name mongoserver1 mongo:4.1`

👉 Sama dengan sebelumnya, tapi **kasih nama custom** (`mongoserver1`).

* Ini memudahkan kamu untuk identifikasi container.
* Status awal tetap = `Created`.

---

Kalau dicek pakai:

```
docker container ls
# kosong (belum jalan)

docker container ls --all
# ada container status "Created"
```

selanjutnya buat lagi container :

docker container create --name mongoserver1 mongo:4.1 (E)

docker container create --name mongoserver2 mongo:4.1

docker container ls --all

---

# Menjalankan Container

---

## 🔹 `docker container start mongoserver1`

👉 Fungsi: **menyalakan container** yang sebelumnya statusnya `Created` atau `Exited`.

* Di sini, container `mongoserver1` (dari image `mongo:4.1`) dijalankan.
* Tapi karena `docker start` **tidak attach ke log/output**, kamu tidak langsung lihat apa-apa di terminal.
* Container jalan di background.

---

## 🔹 `docker container ls`

👉 Alias: `docker ps`

* Sekarang tampil container yang sedang **Running**.
* Harusnya muncul `mongoserver1` dengan image `mongo:4.1`.
* Kolom yang tampil:

  * `CONTAINER ID`
  * `IMAGE` → `mongo:4.1`
  * `COMMAND` → entrypoint dari image MongoDB (biasanya `docker-entrypoint.sh mongod`)
  * `STATUS` → `Up X seconds`
  * `NAMES` → `mongoserver1`

---

## 🔹 `docker container start mongoserver2`

👉 Sama, ini menyalakan container kedua (`mongoserver2`).

* Jadi sekarang ada **dua container MongoDB** yang jalan **bersamaan**.
* Bedanya: keduanya pakai port default MongoDB (27017) di dalam container, tapi karena kamu **belum publish port** (`-p 27017:27017`), maka mereka **tidak bentrok** dan hanya bisa diakses dari sesama container atau dari host via namespace tertentu.

---

## 🔹 `docker container ls`

👉 Cek lagi container yang running.

* Sekarang ada **dua container running**:

  * `mongoserver1`
  * `mongoserver2`
* Status keduanya harus `Up ... seconds/minutes`.

---

# Menghapus Container

---

## 🔹 1. `docker container rm mongoserver1`

👉 Perintah ini **hapus container** bernama `mongoserver1`.

* **TAPI**: kalau container masih **running**, Docker tidak bisa hapus → muncul error:

  ```
  Error response from daemon: You cannot remove a running container ...
  ```
* Jadi container harus dihentikan dulu (`docker stop`) baru bisa dihapus.

---

## 🔹 2. `docker container ls`

👉 Menampilkan container yang sedang **running**.

* Karena sebelumnya `mongoserver1` masih jalan, dia masih akan muncul di sini.

---

## 🔹 3. `docker container stop mongoserver1`

👉 **Menghentikan container** `mongoserver1`.

* Status berubah dari `Up` → `Exited`.
* Container masih ada di sistem, tapi tidak jalan.

---

## 🔹 4. `docker container stop mongoserver1 mongoserver2`

👉 Menghentikan **dua container sekaligus** (`mongoserver1` dan `mongoserver2`).

* Sekarang dua-duanya statusnya `Exited`.
* Kalau sudah di-stop, container tidak akan muncul di `docker container ls` (karena itu hanya menampilkan yang running).

---

## 🔹 5. `docker container ls`

👉 Menampilkan container yang running → hasilnya kosong, karena semua sudah dihentikan.

---

## 🔹 6. `docker container rm mongoserver1`

👉 Sekarang bisa dihapus, karena status `mongoserver1` = Exited.

* Container `mongoserver1` hilang dari sistem.

---

## 🔹 7. `docker container rm mongoserver1 mongoserver2`

👉 Di sini:

* `mongoserver1` sudah dihapus, jadi akan muncul warning/error kalau coba hapus lagi.
* `mongoserver2` masih ada (status Exited), jadi berhasil dihapus.

---

## 🔹 8. `docker container ls --all`

👉 Menampilkan semua container (Running, Exited, Created).

* Karena `mongoserver1` & `mongoserver2` sudah dihapus, mereka tidak muncul lagi.
* Tapi container lain (yang sebelumnya pernah dibuat) mungkin masih ada kalau belum dihapus.

---

## 🔹 9. `docker images`

👉 Menampilkan **image lokal**.

* Penting: `docker container rm` hanya hapus **container**, **image aslinya tetap ada**.
* Jadi image `mongo:4.1` masih muncul di daftar images.

---

# membuka port untuk container

docker container create --name mongoserver1 -p 8080:27017 mongo:4.1
docker container create --name mongoserver2 -p 8181:27017 mongo:4.1
docker container ls --all
docker container start mongoserver1
docker container start mongoserver2
docker container ls

docker container stop mongoserver1

# menghapus image

docker images
docker images rm mongo:4.1 (ERROR, soalnya ada container jalan)
docker container stop mongoserver1
docker container stop mongoserver2
docker container rm mongoserver1
docker container rm mongoserver2
docker container ls
docker container ls --all
docker images rm mongo:4.1
