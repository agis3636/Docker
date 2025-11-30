# Perbedaan TCP vs UDP

## Ringkasan singkat

* **TCP**: protokol koneksi (connection-oriented), andal (reliable), menjamin urutan data, pengendalian aliran dan kongesti. Cocok untuk aplikasi yang butuh integritas data (HTTP, FTP, SMTP, SSH).
* **UDP**: protokol tanpa koneksi (connectionless), ringan, latensi rendah, tidak menjamin keandalan atau urutan. Cocok untuk aplikasi real-time atau aplikasi yang menangani kehilangan data (VoIP, streaming video, DNS, DHCP).

## Konsep dasar

### 1. Model komunikasi

* **TCP**: sebelum transfer data, dua pihak membentuk koneksi (handshake). Setelah komunikasi selesai, koneksi ditutup (teardown).
* **UDP**: tidak ada handshake. Aplikasi cukup kirim paket (datagram) ke alamat tujuan.

### 2. Reliability (keandalan)

* **TCP** menjamin bytes yang dikirim akan sampai (atau pengirim diberi tahu gagal) melalui:

  * nomor urut (sequence number)
  * ACK (acknowledgement)
  * retransmission bila timeout
  * checksum (integritas)
* **UDP** hanya punya checksum opsional; tidak ada retransmission, ACK, atau garansi urutan.

### 3. Ordering (urutan)

* **TCP** menjamin data diterima dalam urutan yang sama seperti dikirim.
* **UDP** tidak menjamin — paket bisa datang out-of-order.

### 4. Flow control & Congestion control

* **TCP**: flow control (receiver window) untuk mencegah receiver kewalahan; congestion control (Slow Start, Congestion Avoidance, Fast Retransmit, Fast Recovery) untuk menghindari kemacetan jaringan.
* **UDP**: tidak punya mekanisme bawaan untuk ini — aplikasi bertanggung jawab jika perlu.

### 5. Overhead & Latensi

* **TCP**: overhead protokol lebih besar (handshake, header lebih panjang, stateful), latensi awal lebih besar (mis. 3-way handshake).
* **UDP**: overhead kecil, latensi rendah — cocok untuk real-time.

---

## Struktur header (ringkas)

### Header TCP (minimal field penting)

* Source Port (16 bit)
* Destination Port (16 bit)
* Sequence Number (32 bit)
* Acknowledgement Number (32 bit)
* Data Offset / Header Length (4 bit)
* Flags (9 bit — SYN, ACK, FIN, RST, PSH, URG, ...)
* Window Size (16 bit) — untuk flow control
* Checksum (16 bit)
* Urgent Pointer (16 bit)
* Options (variable, mis. MSS, SACK, Timestamps)

### Header UDP (sederhana, 8 byte)

* Source Port (16 bit)
* Destination Port (16 bit)
* Length (16 bit) — panjang header + data
* Checksum (16 bit)

> Perbandingan: header UDP hanya 8 byte; header TCP minimal 20 byte (tanpa options).

---

## Mekanisme utama TCP (lebih detail)

1. **3-way handshake**:

   * Client → Server: `SYN (seq=x)`
   * Server → Client: `SYN+ACK (seq=y, ack=x+1)`
   * Client → Server: `ACK (ack=y+1)` → koneksi terbentuk

2. **Reliability**:

   * Setiap byte diberi sequence number; ACK menandakan byte berikutnya yang diharapkan.
   * Retransmission: jika ACK tidak datang dalam timeout, data dikirim ulang.
   * Selective Acknowledgement (SACK) untuk efisiensi retransmission.

3. **Flow control**:

   * Receiver mengirim window size; sender menyesuaikan jumlah byte yang dikirim.

4. **Congestion control**:

   * Algoritma: Slow Start → Congestion Avoidance → Fast Retransmit/Recovery.
   * Tujuan: hindari overloading jaringan.

5. **Teardown**:

   * Connection close via FIN/ACK sequence (empat langkah biasa: FIN, ACK, FIN, ACK).

---

## Karakteristik UDP (lebih detail)

* **Stateless**: router dan host tidak menyimpan state koneksi.
* **Multiplexing** dengan port tetap ada (Source Port, Dest Port), sehingga aplikasi bisa membedakan aliran.
* **Broadcast & Multicast** lebih mudah digunakan (UDP sering dipakai untuk multicast).
* **Aplikasi yang toleran kehilangan** sering memilih UDP karena overhead TCP (retransmission, head-of-line blocking) bisa merugikan kualitas real-time.

---

## Kapan memilih TCP vs UDP (use-cases)

**Pilih TCP jika:**

* Perlu transfer file tanpa korupsi (HTTP, FTP, SFTP).
* Perlu koneksi interaktif yang aman dan andal (SSH).
* Aplikasi menuntut integritas dan urutan data.

**Pilih UDP jika:**

* Aplikasi real-time & interaktif: VoIP, video conferencing, online game.
* DNS queries (request-response singkat).
* DHCP, SNMP, streaming multimedia (kadang memakai RTP over UDP).
* Aplikasi multicast/broadcast.

---

## Kelebihan & Kekurangan (ringkas)

**TCP**

* * Andalan, urutan dijaga, flow control, congestion control.
* * Overhead tinggi, latency awal lebih besar, head-of-line blocking.

**UDP**

* * Ringan, latency rendah, cocok real-time, sederhana.
* * Tidak ada jaminan delivery/order, aplikasi harus tangani kehilangan jika perlu.

---

## Perbandingan singkat dalam tabel

| Fitur              |                            TCP | UDP                        |
| ------------------ | -----------------------------: | :------------------------- |
| Connection         |                  Ya (stateful) | Tidak (stateless)          |
| Reliability        |           Ya (ACK, retransmit) | Tidak                      |
| Urutan data        |                       Terjamin | Tidak                      |
| Flow control       |                             Ya | Tidak                      |
| Congestion control |                             Ya | Tidak                      |
| Overhead header    |                       ≥20 byte | 8 byte                     |
| Latensi awal       |       Lebih tinggi (handshake) | Rendah                     |
| Cocok untuk        | Web, file transfer, email, SSH | VoIP, streaming, DNS, game |

---

## Dampak pada desain aplikasi

* Jika menggunakan **TCP**, aplikasi tidak perlu menangani retransmission atau urutan — protokol transport menangani itu.
* Jika menggunakan **UDP**, aplikasi harus mengimplementasikan sendiri mekanisme bila membutuhkan keandalan (mis. sequence numbers, ACK di level aplikasi, FEC — forward error correction).

## Kesimpulan singkat

* TCP = andal, urut, lebih lambat/ber-overhead — untuk data yang must-have integrity.
* UDP = ringan, cepat, tanpa jaminan — untuk aplikasi real-time atau aplikasi yang menangani reliability sendiri.

---

Berikut **analogi paling mudah dan kuat** untuk menjelaskan perbedaan **TCP vs UDP** ke mahasiswa — bisa langsung dipakai di kelas.

---

# 📨 Analogi TCP vs UDP (Super Jelas)

## **1. TCP = Jasa Kurir Paket dengan Tanda Terima (Kilat/Reguler)**

Bayangkan kamu mengirim barang lewat jasa kurir resmi (JNE, J&T, Pos, dll).

### Ciri-ciri:

* **Sebelum kirim, kurir mencatat data kamu dan penerima** → *3-way handshake*.
* **Setiap paket dicatat, dilacak, dan harus diterima dengan tanda tangan** → *ACK*.
* **Jika paket rusak/hilang, kurir akan mengirim ulang** → *retransmission*.
* **Paket sampai berurutan** — tidak mungkin paket ke-3 sampai duluan dari paket ke-1.
* **Kurir tidak akan membawa terlalu banyak paket kalau penerima lagi sibuk** → *flow control*.
* **Kurir juga mengatur jumlah paket di jalan biar tidak macet** → *congestion control*.

### Intinya:

**TCP seperti kurir profesional**, yang menjamin:

* paket sampai,
* tidak rusak,
* berurutan,
* ada tanda terima.

Tapi prosesnya **lebih lambat**, karena banyak aturan.

---

## **2. UDP = Lempar Selebaran / Brosur ke Rumah Orang**

Bayangkan kamu bagi-bagi brosur di jalan.

### Ciri-ciri:

* Kamu **langsung lempar brosur tanpa salam dan catatan** → *no handshake*.
* Kamu **tidak peduli si penerima terima atau tidak**.
* Tidak ada tanda tangan → *tidak ada ACK*.
* Tidak ada pengecekan urutan → siapa cepat, dia dapat.
* Kalau ada yang jatuh, terbang, atau diinjak orang → **itu risiko**.

### Intinya:

**UDP seperti membagi brosur cepat dan masif.**
Super cepat, tapi **tidak ada jaminan** brosur terbaca atau sampai ke orang yang tepat.

---

# 📘 Ringkasannya

| Protokol | Analogi                              | Penjelasan                                         |
| -------- | ------------------------------------ | -------------------------------------------------- |
| **TCP**  | Jasa kurir resmi dengan tanda terima | Lambat tapi aman, berurutan, ada tracking          |
| **UDP**  | Lempar brosur di jalan               | Sangat cepat tapi tidak andal, tidak peduli urutan |

---

# 🧠 Analogi Tambahan (supaya makin nempel)

## **TCP = Telepon**

* Kamu bicara → lawan bicara jawab.
* Ada “iya”, “oke”, “paham” → ACK.
* Kalau suara tidak jelas, kamu ulangi → retransmission.

## **UDP = Siaran Radio**

* Kamu bicara → banyak orang bisa dengar.
* Kamu tidak tahu siapa yang dengar atau yang hilang.
* Tidak ada "oke saya dengar" dari pendengar.

---

# 🎮 Aplikasi Dunia Nyata dengan Analogi

* **Online Game / Streaming** = butuh *radio cepat* → UDP.
  Kalau satu frame suara/video hilang, tidak masalah, game tetap lanjut.

* **Transfer File / Web / Login SSH** = butuh *kurir paket aman* → TCP.
  Tidak boleh ada 1 byte pun hilang.
