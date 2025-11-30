```
package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":8080", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!")
}
```











---

Kode itu adalah **web server sederhana** dalam bahasa Go.
Ketika diakses melalui browser di **[http://localhost:8080](http://localhost:8080)**, server akan menampilkan:

```
Hello, World!
```

Jadi, fungsi program ini:
### 👉 Membuat Web Server
### 👉 Port yang digunakan: 8080
### 👉 Endpoint “/” akan mengembalikan teks “Hello, World!”

---

# penjelasan line-by-line

```go
package main
```

* Menandakan file ini bagian dari package `main`.
* `main` wajib ada untuk membuat aplikasi Go executable.

---

```go
import (
    "fmt"
    "net/http"
)
```

* Mengimpor library Go:

  * **fmt** → untuk format teks (print, printf).
  * **net/http** → untuk membuat web server.

---

```go
func main() {
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":8080", nil)
}
```

### Penjelasan:

### `http.HandleFunc("/", HelloServer)`

* Artinya: Jika user membuka `/` (root path), jalankan fungsi `HelloServer`.
* Ini adalah **router**.

### `http.ListenAndServe(":8080", nil)`

* Menjalankan server HTTP pada port **8080**.
* `nil` artinya menggunakan default *multiplexer* dari Go.

---

```go
func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!")
}
```

Penjelasan:

* Ini adalah **handler function**.
* Parameter:

  * **w** → tempat kamu menulis response ke client (writer).
  * **r** → request dari client (informasi browser, header, dll).
* `fmt.Fprintf(w, "Hello, World!")` → mengirim teks ke user.

# 🟩 Diagram alur kerjanya

Client buka browser → ke `localhost:8080` → request diterima oleh Go server → route `/` → fungsi `HelloServer` → kirim “Hello, World!” → tampil di browser.
