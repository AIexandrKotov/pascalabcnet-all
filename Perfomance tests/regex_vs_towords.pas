## uses System.Diagnostics;

///тест регексов
procedure test(re, text: string; iters: integer);
begin
  var timer := Stopwatch.StartNew();
  for var i := 0 to iters - 1 do
  begin
    var res := Regex.Match(re, text);
  end;
  timer.Stop;
  timer.ElapsedMilliseconds.Println;
end;

///тест ту вордс
procedure test(text: string; iters: integer);
begin
  var timer := Stopwatch.StartNew();
  for var i := 0 to iters - 1 do
  begin
    var tw := text.ToWords('; :');
  end;
  timer.Stop;
  timer.ElapsedMilliseconds.Println;
end;

var re1 := '/:*\;/';
var text := ' a, b: array[1..10] of integer;';
var iters := 50000000;

test(re1, text, iters);
test(text, iters);
