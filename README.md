# Tokenizer / Lexical Analyzer Pascal
​
Tugas Praktikum #1 - Otomata (Pengenalan Grammar, Pertemuan II)

---

| No | Name | NRP           |
| -- | ---  | ---           |
| 1 | Kineisha Rana Salsabila | 5025241149 |
| 2 | Shifa Alya Dewi  | 5025241176 |
| 3 | Dyah Utami Kesuma Dewi  | 5025241186 |

---

## 1. Deskripsi
​
Program ini membaca sebuah source code (program lain, difokuskan pada bahasa Pascal), memindainya, kemudian menghasilkan token-token dan mengelompokkannya sesuai sifat masing-masing string ke dalam empat kategori:
​
1. Reserved words - kata kunci baku bahasa (contoh: `begin`, `end`, `if`).
2. Simbol dan tanda baca - operator dan delimiter (contoh: `:=`, `+`, `;`).
3. Variabel - identifier bentukan pengguna (contoh: `x`, `hasil`).
4. Kalimat matematika - persamaan (assignment), kondisi, dan pemanggilan fungsi (contoh: `x := a + b`).
​
Program dilengkapi antarmuka pengguna agar kode mudah dimasukkan dan hasilnya mudah dibaca.
​
## 2. Keterkaitan dengan Materi Grammar
​
| Konsep pada materi | Penerapan pada program |
|---|---|
| Himpunan terminal (VT) baku | Daftar reserved words dan simbol |
| Aturan produksi identifier (I -> L \| IL \| ID) | Aturan pembentukan variabel (huruf diikuti huruf/angka) |
| Grammar ekspresi (E -> E + T \| ...) | Deteksi kalimat matematika |
| Derivasi / parsing string | Proses scanning kode menjadi token |
​
## 3. Struktur Berkas
​
| Berkas | Keterangan |
|---|---|
| `tokenizer_pascal.html` | Versi web (dijalankan langsung di browser) |
| `test-pascal/` | Kumpulan berkas uji `.pas` dan kunci hasil |
| `README.md` | Dokumen ini |
​
## 4. Cara Menjalankan
​
### 4.1 Versi Web
1. Klik dua kali berkas `tokenizer_pascal.html`.
2. Berkas akan terbuka di browser (Chrome, Edge, atau Firefox).
3. Tidak memerlukan instalasi dan dapat berjalan secara offline.
​

## 5. Cara Penggunaan
​
1. Masukkan kode Pascal pada kotak editor di sisi kiri, atau gunakan tombol Buka File untuk memuat berkas `.pas`.
2. Klik tombol Analisis Token (atau tekan Ctrl/Cmd + Enter).
3. Hasil ditampilkan di sisi kanan, terdiri atas kartu statistik dan tab per kategori: Reserved Words, Simbol dan Tanda Baca, Variabel, Kalimat Matematika, serta Semua Token.
4. Gunakan tombol Simpan Hasil untuk mengekspor hasil ke berkas `.txt`. Tombol Contoh memuat kode demo, dan tombol Bersihkan mengosongkan editor.
​
## 6. Penjelasan Kode Secara Keseluruhan
​
Program disusun sebagai sebuah pipeline yang meniru tahap awal sebuah compiler. Alur pemrosesan:
​
```
INPUT (kode) -> scan() -> classify() -> extractMath() -> render (tabel hasil)
```
​
Kedua versi (web dan Python) menggunakan logika yang identik; perbedaannya hanya pada bahasa implementasi dan cara menampilkan antarmuka.
​
### 6.1 Definisi Bahasa
​
Bagian ini memuat data acuan yang digunakan seluruh proses:
​
- `RESERVED` - himpunan kata kunci baku Pascal. Perbandingan dilakukan dalam huruf kecil karena Pascal bersifat case-insensitive.
- `MATH_FUNCS` - daftar fungsi matematika bawaan (misalnya `sqrt`, `sin`, `cos`) untuk mengenali ekspresi berbentuk pemanggilan fungsi.
- `SYMBOL_NAME` - pemetaan setiap simbol ke namanya (misalnya `:=` menjadi "assignment").
- `SPEC` / `TOKEN_SPEC` - kumpulan aturan (regular expression) untuk setiap jenis token.
​
### 6.2 Tahap 1 - Scanning (fungsi `scan`)
​
Fungsi ini membaca teks karakter demi karakter dari kiri ke kanan, lalu mencocokkannya dengan aturan token. Aturan yang lebih panjang atau lebih spesifik diperiksa lebih dulu, sehingga `:=` dikenali sebagai satu token dan tidak terpecah menjadi `:` dan `=`.
​
Jenis token yang dikenali:
​
- `COMMENT` - komentar `{ }`, `(* *)`, dan `//`. Komentar dilewati karena bukan token bahasa.
- `STRING` - teks di dalam tanda kutip tunggal.
- `REAL` dan `INT` - bilangan real, bulat, atau heksadesimal.
- `ID` - identifier atau kata kunci, berpola huruf/garis bawah diikuti huruf atau angka.
- `OP` - operator, seperti `:=`, `+`, `-`, `<=`.
- `PUNCT` - tanda baca, seperti `;`, `:`, `,`, `(`, `)`.
- `MISMATCH` - karakter yang tidak dikenali; dicatat sebagai error.
​
Setiap token menyimpan nilai, nomor baris, dan kolom untuk keperluan pelaporan.
​
### 6.3 Tahap 2 - Klasifikasi (fungsi `classify`)
​
Setiap token ditempatkan ke kategori yang sesuai:
​
- Token `ID` yang terdapat dalam `RESERVED` dimasukkan ke Reserved words.
- Token `ID` yang tidak terdapat dalam `RESERVED` dimasukkan ke Variabel. Bila diikuti tanda `(`, token tersebut ditandai pula sebagai pemanggilan fungsi.
- Token `OP` dan `PUNCT` dimasukkan ke Simbol dan tanda baca.
- Token `INT`, `REAL`, dan `STRING` dicatat sebagai literal.
​
### 6.4 Tahap 3 - Deteksi Kalimat Matematika (fungsi `extractMath`)
​
Sebelum diproses, komentar dan isi string dihapus agar operator yang berada di dalamnya tidak ikut terhitung. Selanjutnya program mendeteksi tiga bentuk:
​
- Persamaan (assignment): pola `variabel := ekspresi`. Sisi kanan berhenti pada `;`, akhir baris, atau kata kunci alur seperti `to`, `do`, `then`, sehingga inisialisasi pada perulangan `for` tidak terbaca berlebihan.
- Kondisi atau ekspresi: isi dari `if ... then`, `while ... do`, dan `repeat ... until` yang memuat operator matematika atau relasional.
- Fungsi matematika: pemanggilan fungsi bawaan seperti `sqrt(x)` atau `sin(x)`.
​
### 6.5 Tahap 4 - Ringkasan dan Penyajian
​
Fungsi `summarize` menghitung token unik beserta jumlah kemunculan dan nomor barisnya. Fungsi `analyze` menggabungkan seluruh tahap menjadi satu objek hasil. Hasil tersebut kemudian dirender menjadi tabel per kategori pada antarmuka (halaman web atau jendela Tkinter).
​
## 7. Ringkasan Komponen Kode
​
| Komponen | Peran |
|---|---|
| `RESERVED` | Himpunan kata kunci baku Pascal |
| `MATH_FUNCS` | Daftar fungsi matematika bawaan |
| `SYMBOL_NAME` | Pemetaan simbol ke nama |
| `SPEC` / `TOKEN_SPEC` | Aturan token (regular expression) |
| `scan` | Mengubah teks menjadi daftar token |
| `classify` | Mengelompokkan token ke kategori |
| `extractMath` | Mengekstrak persamaan, kondisi, dan fungsi |
| `summarize` | Menghitung token unik, jumlah, dan baris |
| `analyze` | Menggabungkan seluruh tahap menjadi satu hasil |
​

​
