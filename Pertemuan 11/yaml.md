# Configuration File

[https://yaml.org/](https://yaml.org/)

---

Konversi JSON ke YAML secara online

[https://www.bairesdev.com/tools/json2yaml/](https://www.bairesdev.com/tools/json2yaml/)

---

# Versi Konfigurasi | Compose file version 3 reference

Terdapat beberapa versi format file Compose – 1, 2, 2.x, dan 3.x. Link di bawah ini memberikan gambaran singkat. Untuk detail lengkap tentang apa yang termasuk dalam setiap versi dan cara memperbarui, lihat Tentang versi dan pembaruan.

[https://docker-docs.uclv.cu/compose/compose-file/](https://docker-docs.uclv.cu/compose/compose-file/)

---

## Kenapa Compose v3 sekarang disebut **legacy**?

Ini poin penting dan sering bikin bingung.

### 🔥 DULU

Compose file pakai **versioning**:

```yaml
version: "3"
services:
  app:
    image: nginx
```

Ada:

* v2
* v2.4
* v3
* v3.8

**v3 dibuat khusus untuk Docker Swarm**

---

### ⚠️ SEKARANG (Docker modern)

Docker **menghapus konsep versioning Compose file**.

👉 Semua fitur Compose digabung jadi **Compose Specification tunggal**

Makanya:

* Dokumentasi `version: "3"` **dipindah ke legacy**
* Bukan berarti rusak
* Tapi **tidak direkomendasikan untuk project baru**

---

### 📌 Maksud “Legacy Versions”

Artinya:

* Masih didukung
* Masih jalan
* Tapi **tidak dikembangkan lagi**
* Hanya untuk backward compatibility

---

### ✅ Cara yang BENAR sekarang

**JANGAN pakai `version:` sama sekali**

❌ Lama:

```yaml
version: "3.8"
services:
  app:
    image: nginx
```

✅ Sekarang:

```yaml
services:
  app:
    image: nginx
```

Docker akan:

* Auto-detect
* Pakai Compose Spec terbaru

---

## Dampak Praktis ke Kamu (real world)

Sebagai orang yang sering ngoprek server & container:

* Compose **tanpa version** → lebih future-proof
* Lebih konsisten antara:

  * docker compose
  * docker swarm
  * docker desktop
* Tidak kena deprecated warning
