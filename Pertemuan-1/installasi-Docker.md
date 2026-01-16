# Install Dengan Cara Manual (pakai repo resmi + apt)

## 🔹 1. Hapus paket lama (clean up)

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

👉 Maksudnya: hapus semua kemungkinan paket Docker lama (atau versi lain seperti Podman, containerd bawaan).

* `for pkg in ...; do ...; done` = looping bash.
* `sudo apt-get remove $pkg` = hapus paket bernama `$pkg`.
* Paket yang dihapus misalnya:

  * `docker.io` → versi Docker bawaan Ubuntu repo (biasanya lama/outdated).
  * `docker-doc` → dokumentasi Docker.
  * `docker-compose`, `docker-compose-v2` → tool docker-compose lama.
  * `podman-docker` → versi kompatibilitas Podman.
  * `containerd`, `runc` → runtime container bawaan.

**Tujuan**: biar bersih, tidak bentrok dengan Docker versi resmi.

## 🔹 2. Tambahkan GPG key Docker

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
```

* Update repo Ubuntu.
* Install `ca-certificates` (buat validasi HTTPS) dan `curl` (buat download).

```bash
sudo install -m 0755 -d /etc/apt/keyrings
```

* Bikin folder `/etc/apt/keyrings` dengan permission aman (0755 = root write, others read).

```bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
```

* Download **GPG key resmi Docker** (dipakai untuk verifikasi integritas paket).

```bash
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

* Biar semua user bisa baca file key itu.

## 🔹 3. Tambahkan repo Docker ke sources.list

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

👉 Ini agak panjang, tapi intinya:

* Tambahkan **repository resmi Docker** ke `apt`.
* `dpkg --print-architecture` → deteksi arsitektur CPU (amd64, arm64, dll).
* `$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")` → deteksi versi Ubuntu (jammy = 22.04, focal = 20.04, dll).
* Simpan hasil ke `/etc/apt/sources.list.d/docker.list`.

Dengan ini, sistem kamu bisa download **Docker versi terbaru langsung dari repo resmi Docker**, bukan bawaan Ubuntu.

## 🔹 4. Update & install Docker Engine

```bash
sudo apt-get update
```

👉 Refresh daftar paket (sekarang sudah ada repo Docker).

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

* `docker-ce` → Docker Community Edition (Engine utama).
* `docker-ce-cli` → Docker Client (CLI `docker`).
* `containerd.io` → runtime container yang dipakai Docker untuk jalanin container.
* `docker-buildx-plugin` → plugin untuk build image (lebih modern dari `docker build`).
* `docker-compose-plugin` → plugin Compose v2 (jalan lewat `docker compose`, bukan lagi `docker-compose`).

---

# Install Dengan Script Otomatis (get.docker.com / test.docker.com)

## 🔹 1. Install via script resmi Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

👉 Ini **script resmi dari Docker** (dibuat oleh tim Docker).

* Script ini otomatis melakukan semua langkah manual yang tadi:

  * Hapus paket lama.
  * Tambah GPG key.
  * Tambah repo Docker.
  * Install `docker-ce`, `docker-ce-cli`, `containerd.io`, dll.

📌 Bedanya: kamu nggak perlu ketik satu-satu, semuanya sudah di-otomatisasi.
⚠️ Tapi:

* Kamu nggak lihat detail step-nya (black box).
* Kalau ada error, lebih susah debug dibanding cara manual.

## 🔹 2. `--dry-run`

```bash
sudo sh ./get-docker.sh --dry-run
```

👉 Mode simulasi.

* Script dijalankan **tapi tidak benar-benar install**, hanya menampilkan **apa saja yang bakal dilakukan**.
* Cocok buat ngecek dulu sebelum beneran install.

## 🔹 3. Test / Experimental script

```bash
curl -fsSL https://test.docker.com -o test-docker.sh
sudo sh test-docker.sh
```

👉 Ini **versi “test channel”** dari script Docker.

* Bedanya dengan `get.docker.com`:

  * `get.docker.com` → install **versi stable (stabil)**.
  * `test.docker.com` → install **versi preview / nightly / experimental** (fitur baru, belum tentu stabil).

⚠️ Cocok kalau kamu developer atau butuh coba fitur terbaru Docker.
⚠️ Jangan dipakai di server produksi karena rawan bug.

## 📌 Perbandingan cara manual vs script

| Metode                     | Kelebihan                                                                  | Kekurangan                                 |
| -------------------------- | -------------------------------------------------------------------------- | ------------------------------------------ |
| **Manual (repo + apt)**    | Lebih transparan, mudah debug kalau error, bisa kontrol versi yang dipakai | Step panjang, harus ketik banyak           |
| **Script get.docker.com**  | Cepat, otomatis, cukup 2 baris                                             | Kurang transparan, lebih susah debug       |
| **Script test.docker.com** | Dapat versi terbaru/eksperimental                                          | Tidak stabil, rawan bug di server produksi |

## 🔑 Kesimpulan

* Kalau buat **production / server** → lebih aman pakai **cara manual (repo + apt)** atau **get.docker.com stable**.
* Kalau buat **testing / coba fitur terbaru** → pakai **test.docker.com**.
* Kalau butuh cepat dan nggak ribet → `get.docker.com` paling praktis.

---
