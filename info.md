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

## 📌 Perbandingan

* `docker info` = detail konfigurasi & status runtime Docker di host
* `docker version` = info versi client & server

---



# ngambil image

docker images
docker pull mongo:4.1
docker images

# buat container

docker container ls
docker container ls --all
docker container create mongo:4.1
docker container create --name mongoserver1 mongo:4.1
docker container ls
docker container ls --all
docker container create --name mongoserver1 mongo:4.1 (ERROR)
docker container create --name mongoserver2 mongo:4.1
docker container ls --all

# jalankan container

docker container start mongoserver1
docker container ls
docker container start mongoserver2
docker container ls

# menghapus container

docker container rm mongoserver1
docker container ls
docker container stop mongoserver1
docker container stop mongoserver1 mongoserver2
docker container ls
docker container rm mongoserver1
docker container rm mongoserver1 mongoserver2
docker container ls --all
docker images

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
