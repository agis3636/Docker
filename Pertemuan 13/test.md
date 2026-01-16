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

