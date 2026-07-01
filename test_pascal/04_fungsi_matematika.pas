program FungsiMatematika;
{ Kasus 4: pemanggilan fungsi matematika bawaan }
var
  x, y, z : real;
begin
  x := 9.0;
  y := sqrt(x) + sqr(x);
  z := sin(x) * cos(x) - abs(y);
  writeln('y = ', y:0:2, '  z = ', z:0:2);
end.
