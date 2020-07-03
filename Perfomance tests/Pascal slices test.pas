uses System;
uses System.Diagnostics;

function f1(s: string; a, b: integer) := s[a:b + 1];

function f2(s: string; a, b: integer) := (b < a) or (a < 1) or (b > s.Length) ? '' : s.Substring(a - 1, b - a + 1);

begin
  Readln;
  var str := '123456789' * 1000;
  var t1 := new Stopwatch();
  var t2 := new Stopwatch();
  var count := 20;
  
  var value := 5000;
  
  loop count do
  begin
    t1.Start();
    loop value do f1(str, 1, str.Length - 1);
    t1.Stop;
    
    t2.Start();
    loop value do f2(str, 1, str.Length - 1);
    t2.Stop;
  end;
  Seq(t1, t2).Select(x -> (x.ElapsedTicks / count) / TimeSpan.TicksPerSecond).PrintLines;
  $'f2 быстрее f1 в {t1.ElapsedTicks / t2.ElapsedTicks} раз'.Println;
end.