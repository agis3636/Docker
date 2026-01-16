<img width="1247" height="410" alt="Image" src="https://github.com/user-attachments/assets/6b22c847-c0bf-4abc-8c00-ab1ff837c17e" />

Yang muncul di browser itu **BUKAN login MongoDB**, tapi **Basic Auth mongo-express**.

`mongo-express` **SECARA DEFAULT** pakai **Basic Authentication** sendiri.

Default credential:

```
username: admin
password: pass
```

Makanya:

* web kebuka
* tapi **mentok login popup**
* user `agis` + `rahasia` ❌ **DITOLAK**

Karena itu **bukan buat Mongo**, tapi **buat mongo-express UI**.

---

## SOLUSI 1 (SET USER & PASSWORD UI)

Tambahin env ini ke `mongo-express`:

```yaml
  mongodb-express-example:
    image: mongo-express:latest
    container_name: mongodb-express-example
    ports:
      - "8081:8081"
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: agis
      ME_CONFIG_MONGODB_ADMINPASSWORD: rahasia
      ME_CONFIG_MONGODB_SERVER: mongodb-example

      ME_CONFIG_BASICAUTH_USERNAME: agis
      ME_CONFIG_BASICAUTH_PASSWORD: rahasia
    networks:
      - dockernetwork
    depends_on:
      - mongodb-example
```

Lalu:

```bash
docker compose down
docker compose up -d
```

Akses:

```
http://192.168.80.175:8081
```

Login:

```
agis / rahasia
```

---

## SOLUSI 2 (MATIIN AUTH UI – TIDAK DISARANKAN PROD)

Kalau cuma buat belajar:

```yaml
ME_CONFIG_BASICAUTH: "false"
```

Lengkapnya:

```yaml
environment:
  ME_CONFIG_MONGODB_ADMINUSERNAME: agis
  ME_CONFIG_MONGODB_ADMINPASSWORD: rahasia
  ME_CONFIG_MONGODB_SERVER: mongodb-example
  ME_CONFIG_BASICAUTH: "false"
```

⚠️ **Siapa pun bisa akses UI Mongo**

---

## 🔍 BEDAIN 2 AUTH INI (PENTING)

| Jenis Auth         | Buat Apa        | Env                     |
| ------------------ | --------------- | ----------------------- |
| MongoDB auth       | Login ke DB     | `MONGO_INITDB_*`        |
| mongo-express auth | Login ke WEB UI | `ME_CONFIG_BASICAUTH_*` |

Lu **sudah benar** di MongoDB
Lu **belum set** di mongo-express UI

---

> **mongo-express punya login sendiri, beda sama login MongoDB.**
