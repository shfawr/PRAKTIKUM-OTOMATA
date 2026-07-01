program KomentarString;
{ Kasus 5 (EDGE CASE): := di dalam komentar & string HARUS diabaikan }
(* komentar blok: total := 999 ini bukan token *)
var
  pesan : string;
begin
  { baris ini komentar: x := 123 jangan dihitung }
  pesan := 'teks := ini string, bukan operator';
  writeln('Assignment palsu: a + b * c');  // komentar // a := b
  writeln(pesan);
end.
