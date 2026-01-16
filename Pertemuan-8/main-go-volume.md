```
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("APP_PORT")
	fmt.Println("Run app in port : " + port)
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":"+port, nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s", r.URL.Path[1:])

	dataString := "Hello " + r.URL.Path[1:]
	dataBytes := []byte(dataString)

	destination := os.Getenv("APP_DATA")
	file := destination + "/" + r.URL.Path[1:] + ".txt"
	err := ioutil.WriteFile(file, dataBytes, 0666)
	if err != nil {
		panic(err)
	}
	fmt.Println("DONE Write File : " + file)
}
```








---

# 📌 **Gambaran Umum**

Kode ini adalah sebuah **HTTP server** yang:

1. Membaca **port server** dari environment variable `APP_PORT`
2. Setiap ada request ke URL:

   * Menampilkan “Hello, {path}”
   * Membuat file `.txt` sesuai path request
   * Menulis string “Hello {path}” ke dalam file tersebut
   * Lokasi folder penyimpanan diambil dari environment variable `APP_DATA`

Sederhana tapi powerful: **HTTP → Path → Save to File**.

---

# 🧩 **Penjelasan Detail Baris demi Baris**

## ───────────────────────────────

## 📌 **1. Deklarasi Program**

```go
package main
```

Artinya file ini adalah entry point program Go.

---

## 📌 **2. Import Library**

```go
import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)
```

| Library      | Fungsinya                                  |
| ------------ | ------------------------------------------ |
| **fmt**      | Print teks & format output                 |
| **ioutil**   | Menulis file (WriteFile)                   |
| **net/http** | Membuat server HTTP                        |
| **os**       | Membaca environment variable & path sistem |

---

## 📌 **3. Fungsi main()**

```go
func main() {
	port := os.Getenv("APP_PORT")
	fmt.Println("Run app in port : " + port)
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":"+port, nil)
}
```

### Penjelasan:

### ✔ Ambil port dari environment

```go
port := os.Getenv("APP_PORT")
```

Program tidak hardcoded port; harus diberikan lewat environment.

Contoh:

```
APP_PORT=8080
```

---

### ✔ Print informasi

```go
fmt.Println("Run app in port : " + port)
```

---

### ✔ Set handler untuk route "/"

```go
http.HandleFunc("/", HelloServer)
```

Artinya setiap request → diteruskan ke fungsi **HelloServer**.

---

### ✔ Jalankan HTTP server

```go
http.ListenAndServe(":"+port, nil)
```

Server aktif di port yang sudah ditentukan.

---

## ───────────────────────────────

## 📌 **4. Fungsi Handler: HelloServer()**

Ini bagian paling penting.

```go
func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s", r.URL.Path[1:])
```

### ✔ Ambil path (tanpa "/")

Misal request ke:

```
/agis
```

Maka:

```
r.URL.Path = "/agis"
r.URL.Path[1:] = "agis"
```

Output ke browser:

```
Hello, agis
```

---

### ✔ Buat string

```go
dataString := "Hello " + r.URL.Path[1:]
dataBytes := []byte(dataString)
```

Jika path `agis`, maka datanya:

```
Hello agis
```

---

### ✔ Ambil lokasi folder dari environment

```go
destination := os.Getenv("APP_DATA")
```

Contoh env di Docker:

```
APP_DATA=/storage
```

---

### ✔ Tentukan nama file

```go
file := destination + "/" + r.URL.Path[1:] + ".txt"
```

Jika request: `/agis`

File yang dibuat:

```
/storage/agis.txt
```

---

### ✔ Tulis file

```go
err := ioutil.WriteFile(file, dataBytes, 0666)
```

* Isi file = “Hello agis”
* Permission 0666 = bisa dibaca & ditulis semua user

Jika gagal → panic dan aplikasinya berhenti.

---

### ✔ Logging

```go
fmt.Println("DONE Write File : " + file)
```

---

# 🧠 **Cara Membaca Logika Program (Flow Chart)**

1. User akses URL:

   ```
   http://localhost:8080/nama
   ```

2. Program ambil:

   * port dari APP_PORT
   * folder penyimpanan dari APP_DATA

3. Program tampilkan di browser:

   ```
   Hello, nama
   ```

4. Program membuat file:

   ```
   APP_DATA/nama.txt
   ```

5. Isi file:

   ```
   Hello nama
   ```

6. Program print log:

   ```
   DONE Write File : /storage/nama.txt
   ```
