# **cara install Robo 3T (dulu namanya Robomongo)** *Community Edition* alias **Studio 3T Community Edition**.

---

## 🧩 1. Pahami perbedaan dulu

* **Studio 3T** = versi lengkap (berbayar, tapi ada *trial* dan *community edition*).
* **Robo 3T** = versi lama yang sekarang digabung ke Studio 3T sebagai *Community Edition*.

Kalau kamu cari yang *gratisan & legal*, pakai **Studio 3T Community Edition**.

---

## ⚙️ 2. Cara Install di Linux (Ubuntu/Debian/WSL)

### 🔹 Opsi A — Download dan jalankan langsung (direkomendasikan)

1. **Download file .tar.gz dari situs resminya**

   ```bash
   wget https://download.studio3t.com/studio-3t/linux/2024.5.0/studio-3t-linux-x64.tar.gz
   ```

   *(cek versi terbaru di: [https://studio3t.com/download/](https://studio3t.com/download/))*

2. **Ekstrak file-nya**

   ```bash
   tar -xvzf studio-3t-linux-x64.tar.gz
   ```

3. **Masuk ke folder hasil ekstrak**

   ```bash
   cd studio-3t-linux-x64
   ```

4. **Jalankan aplikasinya**

   ```bash
   ./studio-3t.sh
   ```

   Kalau mau lebih praktis, kamu bisa buat shortcut ke menu apps:

   ```bash
   sudo ln -s ~/studio-3t-linux-x64/studio-3t.sh /usr/local/bin/studio3t
   ```

   Jadi nanti bisa langsung ketik:

   ```bash
   studio3t
   ```

---

### 🔹 Opsi B — Lewat GUI (kalau pakai desktop Linux)

Kalau kamu pakai Ubuntu dengan tampilan GUI:

1. Extract file `.tar.gz`
2. Klik kanan → “Properties” → Tab “Permissions” → centang “Allow executing file as program”
3. Double-click `studio-3t.sh`

---

## 🧰 3. Setelah jalan pertama kali

* Pilih **“Continue with Community Edition”**
* Masukkan **email (optional)** → klik **Activate**
* Studio 3T akan terbuka dan tampil mirip Robo 3T.

---

## 💡 4. Tips tambahan

Kalau kamu mau konek ke MongoDB server:

* Pilih menu **“Connect → New Connection”**
* Masukkan host dan port, misal:

  ```
  mongodb://localhost:27017
  ```
* Klik **Test Connection** → kalau sukses, **Save** → **Connect**

---

## 🔎 5. Cek versi yang kamu pakai

```bash
./studio-3t.sh --version
```

---

Kalau kamu pakai **WSL** tanpa desktop (CLI only), maka GUI-nya gak bisa muncul langsung.
Solusi:

* Install **VcXsrv** atau **X410** di Windows untuk menampilkan GUI Linux.
  Atau
* Gunakan **Robo 3T versi Windows** dan konek ke MongoDB Linux lewat IP WSL (biasanya `172.20.x.x`).
