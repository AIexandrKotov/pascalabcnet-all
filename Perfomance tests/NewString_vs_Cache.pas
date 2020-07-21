program NewString_vs_Cache;

const
  repeats: integer = 50000;

var
  cache: array of string := new string[1000];

function GetNew(count: integer) := new string(' ', count);

function GetCached(count: integer) := cache[count];

procedure Init();
begin
  for var i := 0 to cache.Length - 1 do
    cache[i] := new string(' ', i);
end;

procedure Test1();
begin
  var sw := new Stopwatch();
  sw.Start();
  loop repeats do
    for var i := 0 to cache.Length - 1 do
      GetNew(i);
  sw.Stop();
  Writeln('new strings'.PadRight(25) + $' - {sw.ElapsedMilliseconds}');
end;

procedure Test2();
begin
  var sw := new Stopwatch();
  sw.Start();
  loop repeats do
    for var i := 0 to cache.Length - 1 do
      GetCached(i);
  sw.Stop();
  Writeln('cached strings'.PadRight(25) + $' - {sw.ElapsedMilliseconds}');
end;

begin
  Init();
  Test1();
  Test2();
end.