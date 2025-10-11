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
