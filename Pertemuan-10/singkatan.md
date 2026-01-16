## 1️⃣ `docker build -t agis3636/name:1.2 .`

Ini perintah buat **build image Docker** dari `Dockerfile`.

**Penjelasan per bagian:**

* `docker build` → proses bikin **Docker image**
* `-t` → *tag* (kasih nama & versi image)
* `agis3636/name` → nama image
  (biasanya `username/image-name`)
* `:1.2` → versi (tag image)
* `.` → build dari **folder saat ini** (harus ada `Dockerfile` di situ)

**Hasilnya:**
Docker image bernama:

```
agis3636/name:1.2
```

---

## 2️⃣ `docker container exec -i -t name /bin/sh`

Ini buat **masuk ke container yang lagi jalan** pakai shell `sh`.

**Penjelasan:**

* `docker container exec` → eksekusi perintah di container
* `-i` → interactive (bisa input)
* `-t` → TTY (biar enak dipakai)
* `name` → nama container
* `/bin/sh` → shell ringan (umum di Alpine Linux)

**Biasanya dipakai kalau:**

* Image pakai **Alpine**
* `/bin/bash` **tidak ada**

---

## A `-i` → **interactive (STDIN tetap terbuka)**

### Apa artinya?

`-i` itu **jaga input tetap hidup**.

Secara teknis:

* STDIN (**keyboard input**) **tidak ditutup**
* Container **bisa nerima input dari kita**

Tanpa `-i`:

* Container **nggak nerima input**
* Ketik apa pun → **nggak bereaksi**

### Contoh nyata

```bash
docker exec name cat
```

→ `cat` langsung selesai (nggak bisa ngetik)

```bash
docker exec -i name cat
```

→ Kamu bisa ngetik, dan teksnya di-echo balik

**Intinya:**

> `-i` = *container mau dengerin keyboard kita*

---

## B `-t` → **TTY (Terminal palsu / pseudo-terminal)**

### Apa itu TTY?

TTY = **terminal interface**
`-t` bikin **terminal virtual**, seolah-olah kamu login via SSH.

Tanpa TTY:

* Output mentah
* Nggak ada:

  * prompt (`$`)
  * warna
  * backspace normal
  * clear screen

Dengan TTY:

* Ada prompt
* Warna hidup
* `top`, `htop`, `vi`, `bash` normal
* Ctrl+C, Ctrl+L jalan

### Contoh

```bash
docker exec -i name /bin/sh
```

→ Bisa ngetik, tapi:

* tampilan aneh
* nggak ada prompt
* backspace kacau

```bash
docker exec -it name /bin/sh
```

→ Terminal **normal kayak SSH**







---

## 3️⃣ `docker container exec -i -t name /bin/bash`

Sama seperti sebelumnya, tapi pakai **bash**.

**Perbedaannya dengan `/bin/sh`:**

* `/bin/bash` → fitur lebih lengkap
* `/bin/sh` → lebih ringan

⚠️ **Catatan penting:**
Kalau image berbasis **Alpine**, biasanya **TIDAK ADA `/bin/bash`**
Kalau Debian / Ubuntu → ada `/bin/bash`

Kalau error:

```
exec: "/bin/bash": no such file or directory
```

artinya → bash memang tidak ada.

---

## 4️⃣

```
RUN addgroup -S aretagroup
RUN adduser -S -D -h /app agisuser aretagroup
RUN chown -R agisuser:aretagroup /app
```

Ini biasanya ada di **Dockerfile**, tujuannya **KEAMANAN** (jangan jalanin app pakai root).

### 🔹 `RUN addgroup -S aretagroup`

* Bikin **group Linux**
* `-S` → system group (ringan, tanpa ID besar)

### 🔹 `RUN adduser -S -D -h /app agisuser aretagroup`

* Bikin **user Linux**
* `-S` → system user
* `-D` → tanpa password
* `-h /app` → home directory di `/app`
* `agisuser` → nama user
* `aretagroup` → grup user

### 🔹 `RUN chown -R agisuser:aretagroup /app`

* Ubah **kepemilikan folder `/app`**
* Supaya:

  * user `agisuser` bisa baca/tulis
  * aplikasi **tidak jalan sebagai root**

## 🔥 Kenapa ini penting di Docker?

Karena:

* Root di container = **bahaya**
* Best practice Docker:

```
RUN adduser ...
USER agisuser
```

Supaya:

* lebih aman
* lebih profesional
* cocok buat production
