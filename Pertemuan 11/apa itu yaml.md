YAML (YAML Ain't Markup Language) adalah format serialisasi data yang mudah dibaca manusia, sering digunakan untuk file konfigurasi di banyak alat DevOps seperti Kubernetes, Ansible, dan Terraform, karena strukturnya sederhana berbasis indentasi yang mirip Python, memfasilitasi pertukaran data antar sistem, dan kompatibel dengan semua bahasa pemrograman modern. 

*Poin-Poin Penting YAML:*
- *Format Serialisasi Data:* Mengubah struktur data menjadi teks untuk disimpan atau ditransmisikan.
- *Mudah Dibaca Manusia:* Sintaksisnya bersih dan minimalis, fokus pada indentasi, bukan tanda kurung atau tag yang rumit.
- *Untuk File Konfigurasi:* Sangat populer untuk mendefinisikan konfigurasi aplikasi, layanan, dan infrastruktur (Infrastructure as Code).
- *Struktur Data:* Mendukung tipe data seperti string, angka, daftar (list), dan peta (map/dictionary).
- *Superset JSON:* Setiap file *JSON* yang valid juga merupakan file YAML yang valid.
- *Digunakan di:* *AWS, Kubernetes, Ansible, Terraform,* dan banyak alat *DevOps* lainnya. 

*Contoh Sederhana:*

```yaml
nama: "Budi"
usia: 30
pekerjaan: "Pengembang"
hobi:
  - Membaca
  - Coding
```

Singkatnya, YAML adalah cara sederhana dan elegan untuk mengorganisir data dalam file agar mudah dipahami dan dikelola oleh manusia dan mesin. 

---

## 1️⃣ “YAML Bukan Bahasa Markup™” maksudnya apa?

### ❌ Bahasa Markup itu apa?

Markup = **bahasa buat nandain struktur dokumen ke manusia**
Contoh paling gampang: **HTML, XML**

```html
<h1>Judul</h1>
<p>Paragraf</p>
```

➡️ Fokusnya:

* Tampilan
* Struktur dokumen
* Dibaca manusia **dan** browser

---

### ✅ YAML itu BUKAN markup

YAML **tidak punya tag**, tidak ada `<...>`
YAML **tidak buat tampilan dokumen**

➡️ YAML buat **DATA + KONFIGURASI**

Makanya dia bilang:

> “YAML Bukan Bahasa Markup™”

Artinya:

> Jangan samain YAML dengan HTML/XML

---

## 2️⃣ “Bahasa serialisasi data” itu apa sih?

Ini inti kebingungannya.

### 🧠 Gampangnya:

**Serialisasi data = cara menuliskan data supaya bisa:**

* disimpan ke file
* dikirim lewat network
* dibaca program lain

---

### Contoh DATA di program (konsep)

Misal di pikiran program ada data:

```
nama = "Agis"
umur = 25
skill = ["Linux", "Networking", "Docker"]
```

Nah… **gimana cara nyimpen data itu ke file?**

➡️ Harus diubah jadi **teks**
➡️ Proses itu namanya **serialisasi**

---

## 3️⃣ YAML sebagai hasil serialisasi

### Data tadi ditulis pakai YAML:

```yaml
nama: Agis
umur: 25
skill:
  - Linux
  - Networking
  - Docker
```

➡️ Itu **bukan program**
➡️ Itu **bukan markup**
➡️ Itu **representasi data**

---

## 4️⃣ “mudah dipahami manusia” maksudnya?

Bandingin sama JSON:

### JSON:

```json
{
  "nama": "Agis",
  "umur": 25,
  "skill": ["Linux", "Networking", "Docker"]
}
```

### YAML:

```yaml
nama: Agis
umur: 25
skill:
  - Linux
  - Networking
  - Docker
```

➡️ YAML:

* Lebih bersih
* Lebih sedikit simbol
* Enak buat config manual

Makanya:

* Docker Compose → YAML
* Kubernetes → YAML
* Ansible → YAML
* GitHub Actions → YAML

---

## 5️⃣ “untuk semua bahasa pemrograman” maksudnya?

Bukan berarti YAML itu **bahasa pemrograman** ❌
Tapi:

➡️ **Hampir semua bahasa bisa BACA YAML**

Contoh:

* Python → PyYAML
* Go → yaml.v3
* JavaScript → js-yaml
* Java → SnakeYAML
* PHP → Symfony YAML

Artinya:

* File YAML yang sama
* Bisa dipakai Python, Go, Node, Java
* Format netral

---

## 6️⃣ Jadi inti sebenarnya (versi manusia normal)

Kalimat:

> “YAML adalah bahasa serialisasi data yang mudah dipahami manusia untuk semua bahasa pemrograman”

Kalau diterjemahin bebas:

> **YAML itu cuma format nulis data/config**
> **bukan bahasa coding**
> **bukan buat tampilan**
> **dan bisa dibaca hampir semua bahasa pemrograman**

---

## 7️⃣ Analoginya biar nempel

* **Dockerfile** → resep masak (instruksi)
* **Script Bash** → tukang masaknya
* **YAML** → daftar bahan + takaran

Dia **nggak masak apa-apa**, cuma **nyatet data**

---

## 8️⃣ Satu warning penting (real case)

YAML itu:

* **sensitif spasi**
* indent salah = error atau makna berubah

Contoh salah:

```yaml
services:
web:
  image: nginx
```

Benar:

```yaml
services:
  web:
    image: nginx
```

Makanya YAML kelihatan simpel tapi **bisa nyebelin** kalau belum biasa.
