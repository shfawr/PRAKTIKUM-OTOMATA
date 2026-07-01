program NilaiMahasiswa;
{ Kasus 7: program realistis & lebih panjang untuk demo }
uses crt;

const
  BATAS_LULUS = 60;

var
  nama          : string;
  nilai, jumlah : integer;
  i, n          : integer;
  rata          : real;

function Maksimum(a, b: integer): integer;
begin
  if a > b then
    Maksimum := a
  else
    Maksimum := b;
end;

begin
  clrscr;
  write('Jumlah mahasiswa: ');
  readln(n);

  jumlah := 0;
  for i := 1 to n do
  begin
    write('Nilai ke-', i, ': ');
    readln(nilai);
    jumlah := jumlah + nilai;
  end;

  rata := jumlah / n;
  writeln('Rata-rata = ', rata:0:2);

  if rata >= BATAS_LULUS then
    writeln('LULUS')
  else
    writeln('TIDAK LULUS');

  readln;
end.
