Kalau folder /etc/netplan/ kosong (ga ada file seperti 50-cloud-init.yaml atau 01-netcfg.yaml), itu normal banget di WSL (Windows Subsystem for Linux).

### 🧩 Penjelasannya:

WSL nggak pakai Netplan atau systemd-networkd buat ngatur jaringan.
Jaringan WSL dikonfigurasi otomatis oleh Windows host, bukan oleh Linux-nya.

Jadi di WSL:

File /etc/netplan/ biasanya kosong.

Perintah netplan apply atau netplan try tidak berpengaruh sama sekali ke koneksi.

Interface eth0 kamu di-setup otomatis waktu WSL start, oleh Windows (bukan Netplan).

Makanya walau kamu bikin file 50-cloud-init.yaml, nanti juga gak bakal benar-benar aktif — hanya nyimpen konfigurasi aja.
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
