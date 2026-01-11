Di Docker (baik **Dockerfile** maupun **docker-compose**), opsi **network: bridge | host | none** itu ngatur **cara container terhubung ke jaringan**.

---

## 1️⃣ bridge (DEFAULT)

👉 Paling sering dipakai

**Konsep:**

* Container masuk ke jaringan virtual Docker (bridge)
* Dapet IP internal (misal `172.x.x.x`)
* **Akses keluar bebas**
* **Akses dari luar harus lewat port mapping**

**Ciri penting:**

* Isolasi antar container
* Aman & rapi
* Bisa komunikasi antar container via **nama service** (compose)

**Contoh docker run**

```bash
docker run -d -p 8080:80 nginx
```

**docker-compose**

```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
    network_mode: bridge
```

📌 **Kapan pakai bridge?**

* Web server
* App + DB
* Hampir semua use case normal

---

## 2️⃣ host

👉 Container **numpang langsung ke network host**

**Konsep:**

* **Tidak ada IP container**
* Pakai IP & port host langsung
* Tidak bisa pakai `ports:`

**Ciri penting:**

* Lebih cepat (tanpa NAT)
* **Kurang aman**
* Port bentrok = container gagal jalan

**Contoh**

```yaml
services:
  web:
    image: nginx
    network_mode: host
```

📌 **Kapan pakai host?**

* Monitoring (Prometheus, node-exporter)
* Network tools
* High performance / low latency
* Testing lokal

❗ **Catatan penting**

* Di Windows & Mac → **host tidak full support**
* Paling cocok di **Linux**

---

## 3️⃣ none

👉 **Tidak punya jaringan sama sekali**

**Konsep:**

* No IP
* No internet
* No komunikasi jaringan

**Contoh**

```yaml
services:
  job:
    image: alpine
    network_mode: none
```

📌 **Kapan pakai none?**

* Batch job
* Security testing
* Container yang cuma proses file / CPU

---

## 🔥 Ringkasan Cepat

| Mode   | Internet | Port Mapping | Isolasi | Use Case                |
| ------ | -------- | ------------ | ------- | ----------------------- |
| bridge | ✅        | ✅            | ✅       | Default, web, app       |
| host   | ✅        | ❌            | ❌       | Monitoring, performance |
| none   | ❌        | ❌            | ✅✅      | Job offline             |

---







































Di **bridge**, IP container **BUKAN** satu subnet dengan laptop.

---

## 🔴 KASUS NYATA (ANGKA REAL)

Laptop:

```
IP laptop (host) : 192.168.100.2/24
Gateway          : 192.168.100.1
```

---

# 1️⃣ BRIDGE (DEFAULT)

### Yang SEBENARNYA terjadi

Docker bikin **jaringan sendiri**, beda subnet.

```
Network Laptop (LAN):
192.168.100.0/24
|
|  Laptop / Host
|  192.168.100.2
|
+----------------------+
                       |
                Docker Bridge
                172.17.0.0/16
                       |
           Container IP: 172.17.0.2
```

### Fakta penting

* Container **TIDAK AKAN PERNAH** dapet:

  ```
  192.168.100.3
  ```
* IP container hampir pasti:

  ```
  172.17.x.x
  ```

### Cara aksesnya

```bash
docker run -d -p 8080:80 nginx
```

Akses:

```
http://192.168.100.2:8080
```

Alurnya:

```
Client → 192.168.100.2:8080
      → NAT Docker
      → 172.17.0.2:80
```

📌 **Container DISAMARKAN di belakang host**

---

# 2️⃣ HOST

### Yang terjadi

Container **PAKAI IP HOST**

```
Laptop / Host / Container
IP: 192.168.100.2
```

### Fakta penting

* Container **TIDAK PUNYA IP SENDIRI**
* Tidak ada:

  ```
  172.x.x.x
  ```
* Tidak ada:

  ```
  192.168.100.3
  ```

### Contoh

```bash
docker run -d --network host nginx
```

Akses:

```
http://192.168.100.2:80
```

Dan:

* nginx bind ke **port 80 host**
* Kalau host sudah pakai port 80 → **ERROR**

---

## 🔥 PERBANDINGAN KASAR (PAKE IP)

| Mode   | IP Container | Cara Akses         |
| ------ | ------------ | ------------------ |
| bridge | 172.17.0.2   | 192.168.100.2:8080 |
| host   | ❌ (gabung)   | 192.168.100.2:80   |

---

## ⚠️ KENAPA TIDAK JADI 192.168.100.3?

Karena:

* Docker **BUKAN VM**
* Docker **BUKAN NIC fisik**
* Docker pakai **NAT**, bukan bridge layer-2 ke LAN

> Kalau mau container dapat IP **192.168.100.x**, itu **MACVLAN**, BUKAN bridge biasa.

---

## 🧪 Coba Biar Otak “KLIK”

### Bridge

```bash
docker run -it alpine sh
ip a
```

Lu bakal lihat:

```
eth0: 172.17.0.2
```

### Host

```bash
docker run -it --network host alpine sh
ip a
```

Lu **TIDAK AKAN LIHAT interface baru**

---

## 🎯 KESIMPULAN PALING SINGKAT

* **Bridge** → IP container **172.x**, beda subnet
* **Host** → container **nebeng IP 192.168.100.2**
* **192.168.100.3** ❌ **tidak mungkin**, kecuali macvlan

