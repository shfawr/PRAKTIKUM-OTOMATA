program Error;
{ Kasus 6 (ERROR HANDLING): ada karakter tak dikenal # ? ! }
var
  x : integer;
begin
  x := 5 # 3;
  x := x ? 2;
  writeln('selesai!');
end.
