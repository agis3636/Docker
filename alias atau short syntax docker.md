### 1. `docker container stop`

✅ Bisa disingkat jadi:

```bash
docker stop <nama_container>
```

### 2. `docker container rm`

✅ Bisa disingkat jadi:

```bash
docker rm <nama_container>
```

### 3. `docker images rm`

❌ Ini agak tricky: yang bener bukan `docker images rm` tapi:

```bash
docker rmi <nama_image>
```

👉 `rmi` = **remove image**.
Alias resmi Docker. Jadi jangan pakai `images rm` ya.

### 4. `docker container ls --all`

✅ Bisa disingkat jadi:

```bash
docker ps -a
```

atau

```bash
docker container ls -a
```

📌 Keterangan:

* `docker ps` = sama dengan `docker container ls`
* Tambah `-a` = tampilkan semua container (running + stopped).

## 🔑 Kesimpulan singkat:

* `docker container stop` → `docker stop`
* `docker container rm` → `docker rm`
* `docker image rm` → `docker rmi`
* `docker container ls` → `docker ps`
* `docker container ls --all` → `docker ps -a`
