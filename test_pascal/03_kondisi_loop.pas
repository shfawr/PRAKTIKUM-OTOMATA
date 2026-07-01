program KondisiLoop;
{ Kasus 3: percabangan & perulangan - cek deteksi kondisi }
var
  i, n, total : integer;
begin
  n := 100;
  total := 0;

  if n > 10 then
    writeln('n besar')
  else
    writeln('n kecil');

  for i := 1 to n do
    total := total + i;

  while total > 0 do
    total := total - 10;

  repeat
    n := n - 1;
  until n <= 0;
end.
