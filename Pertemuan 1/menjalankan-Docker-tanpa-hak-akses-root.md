**kenapa setelah install Docker harus pakai `sudo`** dan gimana cara biar gak perlu sudo lagi.

By default, **Docker daemon (dockerd)** jalan sebagai **root user**, jadi kalau kamu jalankan `docker run ...`, butuh akses root → makanya harus `sudo`.
Solusinya: bikin group khusus (`docker`) lalu tambahkan user kamu ke group itu.

## 🔹 1. Buat group `docker`

```bash
sudo groupadd docker
```

* `groupadd` = perintah untuk bikin group baru di Linux.
* `docker` = nama group yang dibuat.
* Kenapa butuh group? → supaya user biasa bisa akses Docker tanpa root.

📌 Kalau group `docker` sudah ada, biasanya keluar error *group exists* → itu normal, lanjut aja.

## 🔹 2. Tambahkan user ke group `docker`

```bash
sudo usermod -aG docker $USER
```

* `usermod` = ubah atribut user.
* `-aG` = tambahkan (`a` = append) user ke group (`G` = supplementary group).
* `docker` = nama group.
* `$USER` = user yang sedang login (misal `agis`).

📌 Artinya: sekarang user kamu jadi anggota group `docker`.

## 🔹 3. Refresh membership group

Secara default, group baru aktif kalau kamu logout/login ulang.

Ada 2 opsi:

1. **Logout & login** (atau reboot VM kalau di VM).
2. Jalankan:

   ```bash
   newgrp docker
   ```

   * `newgrp` = force masuk ke group baru tanpa logout.

## 🔹 4. Tes Docker tanpa sudo

```bash
docker run hello-world
```

* `docker run` = jalankan container.
* `hello-world` = image test resmi dari Docker.

  * Kalau belum ada → otomatis di-*pull* dari Docker Hub.
  * Container ini jalan sebentar, print pesan "Hello from Docker!", lalu keluar.

📌 Kalau berhasil jalan tanpa `sudo` → berarti setting group sudah benar.

## 🔹 5. Error permission pada `~/.docker`

Kalau sebelumnya kamu pernah jalanin `sudo docker ...`, Docker bikin folder config di `/home/<user>/.docker/` tapi dengan owner **root**.
Akibatnya, saat jalankan `docker` tanpa sudo → error:

```
WARNING: Error loading config file: /home/user/.docker/config.json - permission denied
```

### Cara fix:

```bash
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
```

* `chown` = ubah ownership file.
* `"$USER":"$USER"` = owner jadi user kamu dan group kamu.
* `/home/"$USER"/.docker -R` = ubah ownership untuk folder `.docker` beserta semua isinya (`-R` = recursive).

📌 Setelah ini, folder `.docker` sudah bisa diakses user biasa → error hilang.

## 🔑 Kesimpulan

1. Docker jalan sebagai root → makanya awalnya butuh `sudo`.
2. Solusi: bikin group `docker` → tambahkan user → refresh session.
3. Jalankan `docker run hello-world` untuk test.
4. Kalau ada permission error di `~/.docker`, perbaiki dengan `chown`.

👉 Jadi intinya:

* **Sekali setup group ini**, selanjutnya kamu bisa jalanin `docker run`, `docker ps`, dll **tanpa sudo**.
