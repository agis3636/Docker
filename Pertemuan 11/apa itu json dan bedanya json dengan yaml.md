JSON (JavaScript Object Notation) adalah format teks ringan untuk menyimpan dan bertukar data yang mudah dibaca manusia dan diproses mesin, sering digunakan dalam aplikasi web untuk komunikasi antara server dan klien, serta mendukung berbagai bahasa pemrograman sebagai format pertukaran data yang efisien dan fleksibel. Format ini menggunakan pasangan key-value (objek) dan daftar terurut (array) dengan sintaks kurung kurawal {} dan kurung siku []. 

**Fungsi Utama JSON:**

- Pertukaran Data: Memindahkan data antar sistem, khususnya antara server dan aplikasi web.
- Penyimpanan Data: Menyimpan data terstruktur ringan.
- Fleksibel: Tidak bergantung pada bahasa pemrograman tertentu (language-independent). 

**Struktur Dasar JSON:**

- Objek: Kumpulan pasangan key-value yang diapit kurung kurawal {}. Key (kunci) adalah string, dipisahkan dengan titik dua : dari value (nilai), dan dipisahkan koma ,.

      Contoh: {"nama": "Budi", "usia": 30}.

- Array: Daftar nilai yang terurut, diapit kurung siku [], dengan nilai-nilai dipisahkan koma ,.

      Contoh: ["apel", "pisang", "jeruk"]. 

**Mengapa JSON Populer:**

- Ringan: Ukuran file lebih kecil dibanding format lain (seperti XML), mempercepat transfer data.
- Mudah Dibaca: Struktur berbasis teksnya intuitif bagi pengembang.
- Dukungan Luas: Dapat digunakan di hampir semua bahasa pemrograman (PHP, Python, Ruby, dll.) dan platform. 

**Contoh Penggunaan:**

Sering digunakan pada API (Application Programming Interface) untuk mengirim data seperti informasi pengguna, produk, atau hasil pencarian dari server ke halaman web agar dapat ditampilkan secara dinamis. 

---

## 1️⃣ JSON vs YAML itu apa sih sebenarnya?

Dua-duanya **bukan bahasa pemrograman**.
Dua-duanya **format data / konfigurasi**.

Bedanya ada di:

* cara nulis
* tujuan pemakaian
* siapa yang paling “nyaman” (manusia vs mesin)

---

## 2️⃣ Contoh yang SAMA ditulis pakai JSON & YAML

### 📌 Data yang sama

```
nama: Agis
umur: 25
skill: Linux, Networking, Docker
```

---

### 🔹 JSON

```json
{
  "nama": "Agis",
  "umur": 25,
  "skill": ["Linux", "Networking", "Docker"]
}
```

Ciri JSON:

* Banyak `{ } [ ] , "`
* Struktur **ketat**
* Mesin suka
* Manusia kadang capek bacanya

---

### 🔹 YAML

```yaml
nama: Agis
umur: 25
skill:
  - Linux
  - Networking
  - Docker
```

Ciri YAML:

* Minim simbol
* Pakai **indentasi (spasi)**
* Enak dibaca & diedit manusia

---

## 3️⃣ Perbedaan utama (tabel ringkas)

| Aspek          | JSON              | YAML                  |
| -------------- | ----------------- | --------------------- |
| Fokus          | Mesin             | Manusia               |
| Sintaks        | Ketat             | Fleksibel             |
| Simbol         | Banyak            | Sedikit               |
| Komentar       | ❌ Tidak ada       | ✅ Ada (`#`)           |
| Sensitif spasi | ❌ Tidak           | ✅ Iya                 |
| Multi-line     | Ribet             | Mudah                 |
| Dipakai di     | API, config mesin | DevOps, config manual |

---

## 4️⃣ Kenapa JSON dibilang “ramah mesin”?

Karena:

* Struktur **selalu eksplisit**
* Tidak ambigu
* Mudah diparse cepat

Makanya:

* REST API → JSON
* Response backend → JSON
* Data exchange antar service → JSON

Contoh API response:

```json
{
  "status": "ok",
  "data": {
    "user_id": 123
  }
}
```

---

## 5️⃣ Kenapa YAML dibilang “ramah manusia”?

Karena:

* Bisa pakai komentar
* Bisa nulis panjang tanpa ribet
* Enak buat config kompleks

Makanya:

* Docker Compose → YAML
* Kubernetes → YAML
* Ansible → YAML
* GitHub Actions → YAML

---

## 6️⃣ JSON valid = YAML valid (fakta penting)

👉 **JSON itu subset dari YAML**

Artinya:

```json
{
  "a": 1
}
```

Itu **YAML yang valid** juga.

Tapi YAML **tidak selalu JSON**.

---

## 7️⃣ Kapan pakai JSON, kapan pakai YAML?

### Pakai JSON kalau:

* Data dikirim via API
* Fokus ke performa & konsistensi
* Mesin ke mesin

### Pakai YAML kalau:

* File konfigurasi
* Infrastructure / DevOps
* Sering diedit manual

---

## 8️⃣ Kesalahan umum yang sering kejadian

### ❌ YAML

* Salah indent → error
* Spasi vs tab bikin pusing

### ❌ JSON

* Lupa koma
* Lupa tutup `{ }`
* Tidak bisa komentar

---

## 9️⃣ Versi super singkat (buat diinget)

* **JSON** → tegas, kaku, mesin
* **YAML** → santai, rapi, manusia
* **JSON = subset YAML**
* **API → JSON**
* **Config → YAML**

