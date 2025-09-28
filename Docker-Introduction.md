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

selanjutnya buat lagi container dengan nama yang sama , error gak? :

docker container create --name mongoserver1 mongo:4.1

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

## 🔹 `docker container rm mongoserver1`

👉 Perintah ini **hapus container** bernama `mongoserver1`.

* **TAPI**: kalau container masih **running**, Docker tidak bisa hapus → muncul error:

  ```
  Error response from daemon: You cannot remove a running container ...
  ```
* Jadi container harus dihentikan dulu (`docker stop`) baru bisa dihapus.

---

## 🔹 `docker container ls`

👉 Menampilkan container yang sedang **running**.

* Karena sebelumnya `mongoserver1` masih jalan, dia masih akan muncul di sini.

---

## 🔹 `docker container stop mongoserver1`

👉 **Menghentikan container** `mongoserver1`.

* Status berubah dari `Up` → `Exited`.
* Container masih ada di sistem, tapi tidak jalan.

---

## 🔹 `docker container stop mongoserver1 mongoserver2`

👉 Menghentikan **dua container sekaligus** (`mongoserver1` dan `mongoserver2`).

* Sekarang dua-duanya statusnya `Exited`.
* Kalau sudah di-stop, container tidak akan muncul di `docker container ls` (karena itu hanya menampilkan yang running).

---

## 🔹 `docker container ls`

👉 Menampilkan container yang running → hasilnya kosong, karena semua sudah dihentikan.

---

## 🔹 `docker container rm mongoserver1`

👉 Sekarang bisa dihapus, karena status `mongoserver1` = Exited.

* Container `mongoserver1` hilang dari sistem.

---

## 🔹 `docker container rm mongoserver1 mongoserver2`

👉 Di sini:

* `mongoserver1` sudah dihapus, jadi akan muncul warning/error kalau coba hapus lagi.
* `mongoserver2` masih ada (status Exited), jadi berhasil dihapus.

---

## 🔹 `docker container ls --all`

👉 Menampilkan semua container (Running, Exited, Created).

* Karena `mongoserver1` & `mongoserver2` sudah dihapus, mereka tidak muncul lagi.
* Tapi container lain (yang sebelumnya pernah dibuat) mungkin masih ada kalau belum dihapus.

---

## 🔹 `docker images`

👉 Menampilkan **image lokal**.

* Penting: `docker container rm` hanya hapus **container**, **image aslinya tetap ada**.
* Jadi image `mongo:4.1` masih muncul di daftar images.

---

# Membuka Port Mapping untuk Container di Docker

---

## 🔹 `docker container create --name mongoserver1 -p 8080:27017 mongo:4.1`

* Membuat container dari image `mongo:4.1`.
* `--name mongoserver1` → nama container.
* `-p 8080:27017` → **port mapping**:

  * `8080` = port di **host (laptop/server kamu)**
  * `27017` = port default MongoDB di **dalam container**
* Jadi kalau kamu akses `localhost:8080`, sebenarnya request diteruskan ke MongoDB dalam container di port `27017`.
* Status awal: `Created` (belum jalan).

---

## 🔹 `docker container create --name mongoserver2 -p 8181:27017 mongo:4.1`

* Sama, tapi nama `mongoserver2` dan port mapping ke host `8181`.
* Jadi:

  * `mongoserver1` → MongoDB bisa diakses di `localhost:8080`.
  * `mongoserver2` → MongoDB bisa diakses di `localhost:8181`.
* Ini penting, karena **dua container tidak bisa share port host yang sama**.

---

## 🔹 `docker container ls --all`

* Menampilkan semua container (running, stopped, created).
* Harusnya ada 2 container (`mongoserver1` & `mongoserver2`), status `Created`.

---

## 🔹 `docker container start mongoserver1`

* Menyalakan container `mongoserver1`.
* Sekarang MongoDB instance pertama jalan → bisa diakses di `localhost:8080`.

---

## 🔹 `docker container start mongoserver2`

* Menyalakan container `mongoserver2`.
* Sekarang MongoDB instance kedua jalan → bisa diakses di `localhost:8181`.

---

## 🔹 `docker container ls`

* Menampilkan container yang sedang berjalan.
* Harusnya terlihat:

  * `mongoserver1` dengan port mapping `0.0.0.0:8080->27017/tcp`
  * `mongoserver2` dengan port mapping `0.0.0.0:8181->27017/tcp`

Artinya host-port 8080 & 8181 terbuka ke luar, diarahkan ke port 27017 di container masing-masing.

---

## 🔹 `docker container stop mongoserver1`

* Menghentikan container `mongoserver1`.
* Sekarang hanya `mongoserver2` yang masih jalan.
* MongoDB instance di `localhost:8080` tidak bisa diakses lagi, tapi `localhost:8181` masih aktif.

---

## 📌 Ringkasan Konsep

* **Port mapping (-p host:container)** = cara expose aplikasi container ke luar host.
* Kamu bisa punya banyak container dari image yang sama, asalkan port host-nya berbeda.
* Kalau tidak pakai `-p`, aplikasi hanya bisa diakses dari dalam container/bridge network Docker.

---

# Menghapus Image (coba jalankan lagi containernya untuk praktek hapus image)

Oke 🔥, sekarang kita bahas tahap **hapus image**. Aku jelasin runtut sesuai urutan command kamu 👇

---

## 🔹 `docker images`

👉 Menampilkan semua image yang ada di lokal.

* Harusnya ada `mongo:4.1` (image MongoDB yang sebelumnya kamu pull & pakai buat container).

---

## 🔹 `docker images rm mongo:4.1` (ERROR)

👉 Tujuannya: hapus image `mongo:4.1`.

* **Tapi gagal**, karena image ini masih dipakai oleh container yang **running** atau **pernah dibuat**.
* Docker **tidak izinkan hapus image** kalau masih ada container (running/created/exited) yang menggunakannya.
* Error biasanya:

  ```
  Error response from daemon: conflict: unable to remove repository reference "mongo:4.1" (must be forced) - container <id> is using its referenced image
  ```

---

## 🔹 `docker container stop mongoserver1`

👉 Hentikan container `mongoserver1`.

* Status berubah dari `Up` → `Exited`.

---

## 🔹 `docker container stop mongoserver2`

👉 Sama, hentikan container `mongoserver2`.

* Sekarang semua container MongoDB berhenti.

---

## 🔹 `docker container rm mongoserver1`

👉 Hapus container `mongoserver1` (status Exited).

* Container hilang dari daftar.

---

## 🔹 `docker container rm mongoserver2`

👉 Hapus container `mongoserver2`.

* Sekarang semua container MongoDB sudah dihapus.

---

## 🔹 `docker container ls`

👉 Menampilkan container yang running.

* Hasilnya kosong (karena semua sudah dihapus).

---

## 🔹 `docker container ls --all`

👉 Menampilkan semua container (running, stopped, created).

* Hasilnya juga kosong, karena `mongoserver1` & `mongoserver2` sudah dihapus.

---

## 🔹 `docker images rm mongo:4.1`

👉 Sekarang image `mongo:4.1` **berhasil dihapus**, karena:

* Tidak ada container yang memakai image tersebut lagi.
* Setelah ini, `docker images` tidak akan menampilkan `mongo:4.1` lagi.

---

## 📌 Ringkasan konsep

1. **Image tidak bisa dihapus kalau masih dipakai container** (meskipun container-nya stopped).
2. Urutan yang benar untuk hapus image:

   * Stop container → `docker stop <nama>`
   * Hapus container → `docker rm <nama>`
   * Baru hapus image → `docker rmi <image>:<tag>`
3. `docker rmi` = singkatan dari `docker image rm`.
4. `docker images` hanya menampilkan daftar image, bukan container.

---

