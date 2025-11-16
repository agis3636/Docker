# Di **Play-with-Docker (PWD)** atau **Play-on-Linux environment Docker Swarm**, perbedaan *manager* dan *worker* itu begini:

## **Manager Node**

* Mengatur seluruh cluster Swarm
* Bisa **deploy service**, **scale**, **update**, **lihat status cluster**, dll
* Bisa menjalankan container (opsional)

Biasanya kamu **masuk ke manager** kalau mau:

* `docker swarm init`
* `docker service create`
* `docker service ls`
* `docker node ls`
* `docker stack deploy`

**Intinya: kalau kamu mau konfigurasi, eksekusi perintah Docker Swarm, pakai *manager*.**

## **Worker Node**

* Hanya menjalankan container
* Tidak bisa mengatur cluster
* Tidak bisa membuat atau meng-update service
* Hanya menerima task dari manager

Biasanya **tidak perlu kamu sentuh**, kecuali untuk cek container yang sedang jalan:

* `docker ps`
* `docker logs`

## **Jadi kamu harus pakai yang mana?**

**Jawaban: pakai *manager***
Semua perintah konfigurasi cluster, service, stack, jaringan, scaling — semuanya dilakukan dari **manager**.

**Worker hanya untuk menjalankan task**, bukan untuk konfigurasi.

---

Kalau tujuan kamu **belajar Docker dasar** (CRUD images/containers, volume, network, Dockerfile, Compose), **kamu TIDAK perlu Swarm**.

Kamu cukup pakai **1 node saja**, yaitu:

# ✅ Pakai **manager**

Karena:

* Manager adalah node yang punya **fitur Docker lengkap**
* Worker **dibatasi** (hanya eksekusi task Swarm)
* Semua perintah Docker dasar (images, containers, build, compose) **jalan normal di manager**

# 🔥 Fitur yang bisa kamu pelajari dari **manager**

### **1. CRUD Images**

* `docker images`
* `docker pull`
* `docker build`
* `docker rmi`

### **2. CRUD Containers**

* `docker ps`
* `docker run`
* `docker stop`
* `docker rm`

### **3. Volumes**

* `docker volume ls`
* `docker volume create`
* `docker volume inspect`
* `docker run -v`

### **4. Network**

* `docker network ls`
* `docker network create`
* `docker network inspect`

### **5. Dockerfile**

* `docker build -t app:1 .`
* `docker run app:1`

### **6. Docker Compose**

* `docker compose up -d`
* `docker compose down`

Semua ini **tidak butuh worker, tidak butuh swarm**.

# ❌ Worker node tidak cocok buat belajar Docker

Karena worker:

* Tidak bisa build image
* Tidak bisa deploy compose
* Tidak bisa membuat container manual (`docker run`) jika dalam mode swarm
* Tidak bisa mengatur network/volume secara bebas
* Perintah banyak yang dibatasi

Jadi murni cuma buat “mesin eksekusi”.
