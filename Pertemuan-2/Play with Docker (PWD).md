👉 **Kenapa cuma 2 jam?**

Nah, itu memang **aturan mainnya Play with Docker (PWD)** 😅

* PWD itu layanan **gratis** dari Docker untuk belajar.
* Mereka batasi supaya servernya tidak dipakai buat hosting permanen.
* Jadi setiap **session hanya hidup 4 jam max** (2 jam idle, bisa diperpanjang jadi 4 jam).
* Setelah itu instance otomatis **dihapus** (semua container, file, setting ikut hilang).

### 🔹 Cara “akali” kalau butuh lebih lama

* **Klik tombol Extend session** → biasanya muncul sebelum 2 jam habis, jadi bisa lanjut sampai total 4 jam.
* Kalau habis → bikin session baru lagi (tapi mulai dari nol).
* Kalau mau **belajar lebih serius / project lebih panjang**, biasanya pindah ke:

  * **WSL2 + Docker Desktop** di laptop
  * atau sewa **VPS murah** (misalnya di DigitalOcean, Hetzner, AWS free tier, dll.)

⚡ Jadi PWD enaknya buat **latihan cepat / demo**.
Kalau butuh environment Docker **permanen**, mending pakai **lokal (WSL)** atau **VPS**.
