```
package main

import (
    "fmt"
    "net/http"
    "os"
)

func main() {
    port := os.Getenv("APP_PORT")
    fmt.Println("Run app in port : " + port)
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":" + port, nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!")
}
```











---

# 📌 **Penjelasan Lengkap Kode Go**

## 🔎 **1. Struktur Program**

```go
package main
```

* Ini wajib untuk aplikasi Go yang ingin dijalankan sebagai program utama.
* Artinya: file ini adalah entry point aplikasi.

---

## 🔎 **2. Import Library**

```go
import (
    "fmt"
    "net/http"
    "os"
)
```

Artinya kita memakai 3 library bawaan Go:

| Library      | Fungsi                                               |
| ------------ | ---------------------------------------------------- |
| **fmt**      | Menampilkan teks (print)                             |
| **net/http** | Membuat HTTP server, menangani request GET/POST, dll |
| **os**       | Mengambil environment variable, akses ke OS          |

---

## 🔎 **3. Fungsi `main()`**

Ini adalah fungsi pertama yang dijalankan ketika program dimulai.

```go
func main() {
    port := os.Getenv("APP_PORT")
    fmt.Println("Run app in port : " + port)
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":" + port, nil)
}
```

### Rincian:

### **a. Ambil Environment Variable**

```go
port := os.Getenv("APP_PORT")
```

* Program mengambil nilai environment variable **APP_PORT**
* Contoh jika di Docker:

  ```sh
  -e APP_PORT=8080
  ```

  maka variabel `port` akan berisi `"8080"`

---

### **b. Print ke console**

```go
fmt.Println("Run app in port : " + port)
```

Hanya menampilkan bahwa server berjalan di port tersebut.

---

### **c. Daftarkan Handler untuk path '/'**

```go
http.HandleFunc("/", HelloServer)
```

Artinya:

* Setiap request ke **/** (root URL)
* Akan ditangani oleh fungsi **HelloServer**

---

### **d. Jalankan HTTP server**

```go
http.ListenAndServe(":" + port, nil)
```

* Membuat web server HTTP dengan port yang diambil dari environment variable.
* Tanda `":" + port` berarti jika port=8080 → `":8080"`

---

## 🔎 **4. Fungsi Handler**

```go
func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!")
}
```

Ini fungsi yang menanggapi request HTTP.

### Parameter:

* **w http.ResponseWriter** → tempat kita menulis response untuk dikirim ke client.
* **r *http.Request** → informasi request (method, header, body).

### Ini akan mengirimkan:

```
Hello, World!
```

ke browser.

---

# 🎯 **Cara Membacanya (Step-by-step Logika Program)**

Bayangkan cara membacanya seperti skrip naratif:

1. **Mulai aplikasi**
2. Ambil nilai port dari environment variable `APP_PORT`
3. Print port tersebut
4. Daftarkan URL root "/" agar ditangani fungsi HelloServer
5. Jalankan HTTP server di port tersebut
6. Jika ada request ke "/", jalankan fungsi:

   * Tulis “Hello, World!” ke browser.
