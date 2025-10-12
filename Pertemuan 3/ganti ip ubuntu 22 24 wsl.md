### Kenapa File Konfigurasi IP Address Kosong?

Kalau folder `/etc/netplan/` kosong (ga ada file seperti `50-cloud-init.yaml` atau `01-netcfg.yaml`), **itu normal banget di WSL** (Windows Subsystem for Linux).

### 🧩 Penjelasannya:

WSL **nggak pakai Netplan atau systemd-networkd** buat ngatur jaringan.
Jaringan WSL dikonfigurasi **otomatis oleh Windows host**, bukan oleh Linux-nya.

Jadi di WSL:

* File `/etc/netplan/` biasanya **kosong**.
* Perintah `netplan apply` atau `netplan try` **tidak berpengaruh sama sekali** ke koneksi.
* Interface `eth0` kamu di-setup otomatis waktu WSL start, oleh Windows (bukan Netplan).

Makanya walau kamu bikin file `50-cloud-init.yaml`, nanti juga gak bakal benar-benar aktif — hanya nyimpen konfigurasi aja.

### ⚙️ Kalau kamu mau cek jaringan aktif di WSL:

Gunakan:

```bash
ip addr show
ip route
cat /etc/resolv.conf
```

Itu yang real dipakai sama WSL (bukan yang dari Netplan).

### ✅ Kesimpulan:

* Kosongnya `/etc/netplan/` = **normal di WSL**.
* WSL **pakai konfigurasi otomatis dari Windows**, bukan dari file Netplan.
* Jadi kalau mau ubah IP, gateway, atau DNS di WSL, kamu bisa:

  * Tambahkan route manual:

    ```bash
    sudo ip route add default via 172.20.144.1
    ```
  * Atau ubah DNS manual (kalau mau tetap):

    ```bash
    sudo nano /etc/resolv.conf
    ```

    *(kadang /etc/resolv.conf digenerate otomatis juga — nanti bisa dikunci kalau perlu)*

---

### ✅ Contoh format Netplan yang benar (non-DHCP, static IP)

Coba kamu ubah file `/etc/netplan/50-cloud-init.yaml` jadi seperti ini:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 172.20.155.143/20
      routes:
        - to: default
          via: 172.20.144.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

### ⚙️ Setelah itu jalankan:

```bash
sudo chmod 600 /etc/netplan/50-cloud-init.yaml
sudo netplan try
```

Kalau tidak error, lanjut:

```bash
sudo netplan apply
```

---

### Bedanya 50-cloud-init.yaml dan 01-netcfg.yaml

File `50-cloud-init.yaml` dan `01-netcfg.yaml` **dua-duanya** adalah file konfigurasi jaringan untuk **Netplan**, tapi dibuat oleh **dua mekanisme yang berbeda**.

---

## ⚙️ 1. `01-netcfg.yaml`

🧩 **Biasanya dibuat manual atau oleh installer Ubuntu (non-cloud)**
Contohnya kalau kamu install Ubuntu Desktop atau Server biasa dari ISO.

* Lokasinya: `/etc/netplan/01-netcfg.yaml`
* Fungsinya: konfigurasi jaringan dasar dari sistem lokal.
* Nama “01” dikasih supaya **prioritasnya paling awal** (urutan diurutkan berdasarkan angka).
* Bisa kamu edit sesuka hati.

🧠 Biasanya ini yang kamu temui kalau install Ubuntu Server di VM, baremetal, atau Proxmox.

## ☁️ 2. `50-cloud-init.yaml`

🧩 **Dibuat otomatis oleh Cloud-Init (cloud deployment seperti AWS, Azure, GCP, dsb.)**

* Nama `50-` artinya **prioritasnya lebih tinggi** dari `01-`.
* File ini **dihasilkan otomatis oleh paket `cloud-init`** waktu instance pertama kali boot.
* Tujuannya untuk membaca metadata dari cloud provider (contoh: IP static dari AWS) dan bikin konfigurasi network secara otomatis.
* Kalau kamu ubah manual, kadang cloud-init akan menimpa lagi di reboot berikutnya.

### Contoh isinya:

```yaml
network:
  version: 2
  ethernets:
    ens3:
      dhcp4: true
```

🧠 File ini sering muncul di VPS, cloud server, atau Ubuntu image yang berbasis cloud.

## 🔍 Jadi Perbedaannya Singkatnya:

| Aspek               | `01-netcfg.yaml`                    | `50-cloud-init.yaml`                    |
| ------------------- | ----------------------------------- | --------------------------------------- |
| Siapa yang bikin    | Kamu sendiri / installer Ubuntu     | Cloud-init (otomatis)                   |
| Digunakan di        | Server lokal / VM manual            | VPS / cloud (AWS, Azure, dsb.)          |
| Prioritas           | Lebih rendah (dipakai duluan)       | Lebih tinggi (menimpa konfigurasi lain) |
| Aman di-edit manual | ✅ Aman                              | ⚠️ Bisa ditimpa cloud-init              |
| Tujuan utama        | Konfigurasi network manual permanen | Konfigurasi awal dari metadata cloud    |

---
