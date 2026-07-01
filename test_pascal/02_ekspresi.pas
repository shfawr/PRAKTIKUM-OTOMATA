program Ekspresi;
{ Kasus 2: banyak persamaan / kalimat matematika }
var
  a, b, c, d, r : real;
begin
  a := 2.5;
  b := (a + 1) * 3;
  c := a * b - 4 / 2;
  d := (a + b) * (c - a) / 2;
  r := a + b - c + d;
end.
