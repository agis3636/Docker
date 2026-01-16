# WORDPRESS

### File: `docker-compose.yml`

Silakan *copy-paste* kode di bawah ini ke dalam file `docker-compose.yml` Anda:

```yaml
version: '3.8'  # Versi format docker-compose

services:
  # --- Service 1: Database (MySQL) ---
  db:
    image: mysql:5.7
    container_name: wp_database_container  # Memberi nama wadah biar gampang dicari
    restart: always  # Kalau container crash atau PC restart, dia otomatis nyala lagi
    environment:
      # Settingan username & password database (Wajib sama dengan yang di WordPress bawah)
      MYSQL_ROOT_PASSWORD: passwordrahasia  # Password root database
      MYSQL_DATABASE: wordpress_db          # Nama database yang akan dibuat
      MYSQL_USER: user_wp                   # User khusus untuk wordpress
      MYSQL_PASSWORD: password_wp           # Password untuk user tersebut
    volumes:
      # Menyimpan data database agar tidak hilang saat container dimatikan
      - db_data:/var/lib/mysql

  # --- Service 2: WordPress (Aplikasi) ---
  wordpress:
    image: wordpress:latest # Menggunakan versi terbaru (sudah include PHP & Apache)
    container_name: wp_app_container
    restart: always
    depends_on:
      - db  # WordPress baru akan jalan SETELAH database siap
    ports:
      # Mapping Port: "Port Komputer Anda : Port Container"
      # Nanti aksesnya di browser: http://localhost:8080
      - "8080:80"
    environment:
      # Menghubungkan WordPress ke Database di atas
      WORDPRESS_DB_HOST: db:3306        # 'db' adalah nama service di atas
      WORDPRESS_DB_USER: user_wp        # Harus sama dengan MYSQL_USER
      WORDPRESS_DB_PASSWORD: password_wp # Harus sama dengan MYSQL_PASSWORD
      WORDPRESS_DB_NAME: wordpress_db   # Harus sama dengan MYSQL_DATABASE
    volumes:
      # Menyimpan file-file wordpress (plugin, themes, uploads) agar tidak hilang
      - wp_data:/var/www/html

# --- Volumes Definition ---
# Ini tempat mendefinisikan "Hardisk Virtual" untuk menyimpan data
volumes:
  db_data: # Wadah data database
  wp_data: # Wadah data file wordpress

```

---

### Cara Menjalankan (Praktek di WSL/Ubuntu)

1. **Buat Folder Project:**
Ketik ini di terminal Anda:
```bash
mkdir my-wordpress
cd my-wordpress

```


2. **Buat File YAML:**
```bash
nano docker-compose.yml

```


*(Paste kode di atas ke sini. Tekan `CTRL+O`, `Enter` untuk save, lalu `CTRL+X` untuk keluar).*
3. **Jalankan Docker:**
```bash
docker compose up -d

```


*Tunggu proses download (pulling) selesai. Ini butuh internet.*
4. **Akses di Browser:**
Buka browser di Windows Anda, lalu ketik:
👉 **`http://localhost:8080`**
Anda akan langsung melihat layar instalasi WordPress (pilih bahasa, input judul situs, dll).

---

Jika mau mematikan servernya, cukup ketik:

```bash
docker compose down

```
---

---

# REACT.JS

tidak perlu mengotori laptop dengan install Node.js. Biarkan Docker yang menangani "jeroan" mesinnya, laptop cukup jadi tempat simpan file kodingannya saja.

simpan file ini di dalam folder project hasil clone tadi.

### File: `compose.yaml`

```yaml
version: '3.8'

services:
  app-react:
    # Kita pinjam Image Node.js versi berapa aja (Alpine linux yang ringan)
    image: node:22-alpine
    
    container_name: react-wsl-project
    
    # Set folder kerja di dalam container
    working_dir: /app
    
    # VOLUME (Jembatan antara WSL/linux & Container)
    # Ini akan membuat codingan di WSL/linux terbaca di dalam container.
    # Karena belum npm install, nanti folder 'node_modules' 
    # akan otomatis muncul di folder laptop setelah container jalan.
    volumes:
      - ./:/app
      
    # PORT
    # Kiri (8000): Akses dari browser Windows
    # Kanan (3000): Port default React (5173 jika pakai Vite)
    ports:
      - "8000:3000"
      
    # ENVIRONMENT KHUSUS WSL
    # Wajib ada supaya kalau edit file, browser otomatis refresh (Hot Reload)
    environment:
      - CHOKIDAR_USEPOLLING=true
      - WATCHPACK_POLLING=true
      
    # COMMAND (Otomatisasi)
    # Karena di laptop ga ada node_modules, kita suruh container:
    # 1. "npm install" dulu (download library ke folder project)
    # 2. Baru setelah itu "npm start"
    command: sh -c "npm install && npm start -- --host"
    
    # Biar terminal ga langsung close kalau ada error
    stdin_open: true
    tty: true

```

---

1. **Jalankan Perintah:**
Ketik:
```bash
docker compose up

```



2. **Buka Browser:**
Akses: **`http://localhost:8000`**


---

---

# NEXTCLOUD

**Langkah-langkah:**

1. Buat folder:
```bash
mkdir my-cloud
cd my-cloud

```


2. Buat file `docker-compose.yml`:
```bash
nano docker-compose.yml

```


3. Isi dengan script ini (Saya buatkan versi simpel pakai Database MariaDB):
```yaml
version: '3.8'

services:
  # 1. Database (Wajib buat nyimpen data user)
  db:
    image: mariadb:10.6
    container_name: nextcloud_db
    restart: always
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    environment:
      MYSQL_ROOT_PASSWORD: passwordrahasia
      MYSQL_PASSWORD: password_db_cloud
      MYSQL_DATABASE: nextcloud
      MYSQL_USER: nextcloud
    volumes:
      - db_data:/var/lib/mysql

  # 2. Aplikasi Nextcloud
  app:
    image: nextcloud:latest
    container_name: nextcloud_app
    restart: always
    ports:
      - "8081:80"  # Kita pakai port 8081 (biar gak bentrok sama WP 8080)
    environment:
      MYSQL_HOST: db
      MYSQL_PASSWORD: password_db_cloud
      MYSQL_DATABASE: nextcloud
      MYSQL_USER: nextcloud
    volumes:
      - nextcloud_data:/var/www/html
    depends_on:
      - db

volumes:
  db_data:
  nextcloud_data:

```


4. Jalankan:
```bash
docker compose up -d

```

---




---

# JELLYFIN

### Langkah 1: Siapkan Struktur Folder

Jellyfin butuh tempat buat nyimpen data aplikasinya (Config) dan tempat buat baca filmnya (Media).

1. Buat folder project:
```bash
mkdir jellyfin
cd jellyfin

```


2. Buat folder dummy untuk media (nanti bisa diganti):
```bash
mkdir media

```



---

### Langkah 2: File `docker-compose.yml`

Buat file baru (`nano docker-compose.yml`), lalu copy-paste script di bawah ini.
Sudah saya kasih **komentar super lengkap** biar paham fungsinya.

```yaml
version: "3.8"

services:
  jellyfin:
    # Kita pakai image dari linuxserver (Komunitas Docker terbesar)
    # Alasannya: Lebih stabil urusan permission file dibanding official
    image: lscr.io/linuxserver/jellyfin:latest
    
    container_name: jellyfin
    
    # Environment Variables (PENTING BUAT ANTI ERROR)
    environment:
      # PUID & PGID: Ini ID user Linux kamu. 
      # 1000 biasanya adalah user utama (agis).
      # Ini memastikan Jellyfin punya hak akses yang sama kayak kamu.
      - PUID=1000
      - PGID=1000
      
      # Zona waktu biar jam di log bener
      - TZ=Asia/Jakarta
      
    # Volume (Penyimpanan)
    volumes:
      # 1. Config: Nyimpen database film, cover, metadata.
      # Jangan diubah posisinya biar data gak ilang pas restart.
      - ./config:/config
      
      # 2. Media: Ini folder tempat film kamu berada.
      # Formatnya: "- /lokasi/asli/di/laptop : /data/movies"
      # CONTOH: Kalau film kamu ada di folder Download, ganti baris kiri.
      - ./media:/data/media
      
    # Ports (Pintu Akses)
    ports:
      - "8096:8096" # Port Web UI (HTTP)
      # - "8920:8920" # Port HTTPS (Opsional, jarang dipake kalau di lokal)
      
    # Hardware Acceleration (Opsional - Buat yang punya Intel QuickSync/VGA)
    # Kalau error saat 'up', hapus/comment bagian 'devices' ini.
    # Ini fungsinya biar nonton film 4K gak ngelag (Transcoding pakai VGA).
    devices:
      - /dev/dri:/dev/dri
      
    # Kebijakan Restart
    restart: unless-stopped
    
    # Network (Opsional, kalau mau digabung sama Nginx Proxy Manager)
    # networks:
      # - web-network

# networks:
  # web-network:
    # external: true

```

---

### Langkah 3: Jalankan!

Ketik mantra sakti:

```bash
docker compose up -d

```

### Langkah 4: Cara Setup (Penting)

1. **Cek Log (Memastikan Aman):**
```bash
docker compose logs -f

```

---

```text
📁 jellyfin/                <-- Folder Project Utama
├── 📄 docker-compose.yml   <-- File Script tadi
├── 📁 config/              <-- (Otomatis muncul pas dijalankan, isinya database)
└── 📁 media/               <-- 📂 MASUKIN FILM KAMU DI SINI
      ├── 📄 Spiderman.mp4
      ├── 📄 Avengers.mkv
      └── 📁 Drama Korea/
             ├── 📄 Episode1.mp4
             └── ...

```

---

# Stirling-PDF

**Masalah:**
Sering perlu **Merge PDF, Split PDF, Convert PDF to Word, atau Tanda Tangan PDF**?
Biasanya orang pakai website gratisan (seperti iLovePDF). Bahayanya, dokumen rahasia kamu diupload ke server orang lain.

**Solusinya:**
Stirling-PDF adalah aplikasi web yang fiturnya LENGKAP BANGET buat ngedit PDF, tapi jalan di server kamu sendiri. Dokumen aman, gak keluar kemana-mana.

1. Folder: `mkdir pdf-tools` -> `cd pdf-tools`.
2. File `docker-compose.yml`:
```yaml
version: '3.3'
services:
  stirling-pdf:
    image: frooodle/s-pdf:latest
    container_name: stirling_pdf
    ports:
      # HATI-HATI! Port internalnya 8080.
      # Karena 8080 sudah dipake WordPress kamu, kita GANTI depannya jadi 8085
      - '8085:8080'
    volumes:
      - ./trainingData:/usr/share/tessdata # Buat OCR (baca teks di gambar)
      - ./extraConfigs:/configs
    environment:
      - DOCKER_ENABLE_SECURITY=false
    restart: always

```


3. Jalankan: `docker compose up -d`.
4. Buka: `http://localhost:8085`.

---

