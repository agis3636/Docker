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
