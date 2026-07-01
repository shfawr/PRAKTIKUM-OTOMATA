==================================================================
  FILE UJI (TEST CASES) - TOKENIZER PASCAL (Tugas Praktikum #1)
==================================================================

Cara pakai:
  1. Buka tokenizer_pascal.html (double-click) ATAU jalankan
     python tokenizer_pascal.py
  2. Klik "Buka File" -> pilih salah satu file .pas di folder ini
  3. Cek tiap tab: Reserved Words / Simbol / Variabel / Kalimat Matematika
  4. Bandingkan dengan "HASIL YANG DIHARAPKAN" di bawah.

------------------------------------------------------------------
01_dasar.pas   -> uji dasar semua kategori
------------------------------------------------------------------
  Reserved words : program, var, integer, begin, writeln, end
  Variabel       : Dasar, x, y, hasil
  Simbol         : , : ; := + ( ) .
  Kalimat mtk    : x := 10 ; y := 5 ; hasil := x + y

------------------------------------------------------------------
02_ekspresi.pas   -> banyak persamaan matematika
------------------------------------------------------------------
  Kalimat mtk (assignment) yang harus muncul:
    a := 2.5
    b := (a + 1) * 3
    c := a * b - 4 / 2
    d := (a + b) * (c - a) / 2
    r := a + b - c + d
  Variabel : Ekspresi, a, b, c, d, r
  Literal  : ada angka real 2.5, 1, 3, 4, 2 ...

------------------------------------------------------------------
03_kondisi_loop.pas   -> percabangan & perulangan
------------------------------------------------------------------
  Reserved : program,var,integer,begin,if,then,writeln,else,for,to,
             do,while,repeat,until,end
  Kalimat mtk yang harus terdeteksi:
    Kondisi : n > 10 ,  total > 0
    Kondisi : n <= 0   (dari repeat..until)
    Assignment: n := 100, total := 0, total := total + i,
                total := total - 10, n := n - 1, i := 1
  Catatan: 'i := 1' terbaca dari for (RHS berhenti sebelum 'to').

------------------------------------------------------------------
04_fungsi_matematika.pas   -> fungsi bawaan
------------------------------------------------------------------
  Kalimat mtk:
    Assignment      : x := 9.0, y := sqrt(x) + sqr(x),
                      z := sin(x) * cos(x) - abs(y)
    Fungsi mtk      : sqrt(x), sqr(x), sin(x), cos(x), abs(y)
  Variabel : FungsiMatematika, x, y, z (sqrt/sin/cos/abs = fungsi)

------------------------------------------------------------------
05_komentar_string.pas   -> EDGE CASE (paling penting!)
------------------------------------------------------------------
  Yang HARUS diabaikan (TIDAK boleh jadi token/kalimat mtk):
    - 'total := 999' di dalam (* ... *)
    - 'x := 123'     di dalam { ... }
    - 'a := b'       di dalam komentar //
    - 'teks := ...'  di dalam string '...'
    - 'a + b * c'    karena berada di dalam string
  Kalimat mtk yang BENAR muncul hanya:
    pesan := (string literal)  -> assignment ke variabel 'pesan'
  >> Jika := dari komentar/string ikut terhitung, berarti ADA BUG.

------------------------------------------------------------------
06_error.pas   -> ERROR HANDLING
------------------------------------------------------------------
  Di tab Ringkasan harus muncul peringatan karakter tak dikenal:
    '#' (baris 6), '?' (baris 7)
  Tanda '!' di dalam string 'selesai!' TIDAK dianggap error.

------------------------------------------------------------------
07_lengkap.pas   -> demo program realistis (paling bagus untuk presentasi)
------------------------------------------------------------------
  Menggabungkan: const, function, for-loop, if-else, I/O.
  Cek:
    - 'BATAS_LULUS' terbaca sebagai variabel/identifier (konstanta)
    - fungsi Maksimum, clrscr, readln, writeln, write terdeteksi
    - Kalimat mtk: jumlah := jumlah + nilai, rata := jumlah / n,
                   kondisi a > b, rata >= BATAS_LULUS

==================================================================
  Checklist penilaian:
  [ ] Semua token terkelompok benar
  [ ] Komentar & string diabaikan (05)
  [ ] Karakter aneh terdeteksi sebagai error (06)
  [ ] Jumlah & nomor baris token sesuai hitungan manual
==================================================================
