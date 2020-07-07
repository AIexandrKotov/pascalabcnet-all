program StringBuilder_vs_Concat;

uses System;
uses System.Diagnostics;
uses System.Text;

const
  d: real = 2.28;
  perc_str: string = '%';
  repeats: integer = 1000000;

//short string concat
procedure Test1;
begin
  Write('short string concat'.PadRight(35) + ' - ');
  var sw := new Stopwatch();
  var Result: string;
  sw.Start();
  loop repeats do
  begin
    var k := Round(((d - 1) * 100), 2);
    Result := (k < 0 ? '-' : k > 0 ? '+' : '') + Math.Abs(k) + perc_str;
  end;
  sw.Stop;
  Writeln(sw.ElapsedMilliseconds);
end;

//short string building
procedure Test2;
begin
  Write('short string building'.PadRight(35) + ' - ');
  var sw := new Stopwatch();
  var Result: string;
  sw.Start();
  loop repeats do
  begin
    var sb := new StringBuilder();
    var k := Round(((d - 1) * 100), 2);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    Result := sb.ToString();
  end;
  sw.Stop;
  Writeln(sw.ElapsedMilliseconds);
end;

//short string building with cache
procedure Test3;
begin
  Write('short string building with cache'.PadRight(35) + ' - ');
  var sw := new Stopwatch();
  var Result: string;
  var sb := new StringBuilder();
  sw.Start();
  loop repeats do
  begin
    sb.Clear();
    var k := Round(((d - 1) * 100), 2);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    Result := sb.ToString();
  end;
  sw.Stop;
  Writeln(sw.ElapsedMilliseconds);
end;

//long string concat
procedure Test4;
begin
  Write('long string concat'.PadRight(35) + ' - ');
  var sw := new Stopwatch();
  var Result: string;
  sw.Start();
  loop repeats do
  begin
    var k := Round(((d - 1) * 100), 2);
    Result := (k < 0 ? '-' : k > 0 ? '+' : '') + Math.Abs(k) + perc_str + (k < 0 ? '-' : k > 0 ? '+' : '') + Math.Abs(k) + perc_str + (k < 0 ? '-' : k > 0 ? '+' : '') + Math.Abs(k) + perc_str + (k < 0 ? '-' : k > 0 ? '+' : '') + Math.Abs(k) + perc_str + (k < 0 ? '-' : k > 0 ? '+' : '') + Math.Abs(k) + perc_str;
  end;
  sw.Stop;
  Writeln(sw.ElapsedMilliseconds);
end;

//long string building
procedure Test5;
begin
  Write('long string building'.PadRight(35) + ' - ');
  var sw := new Stopwatch();
  var Result: string;
  sw.Start();
  loop repeats do
  begin
    var sb := new StringBuilder();
    var k := Round(((d - 1) * 100), 2);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    Result := sb.ToString();
  end;
  sw.Stop;
  Writeln(sw.ElapsedMilliseconds);
end;

//long string building with cache
procedure Test6;
begin
  Write('long string building with cache'.PadRight(35) + ' - ');
  var sw := new Stopwatch();
  var Result: string;
  var sb := new StringBuilder();
  sw.Start();
  loop repeats do
  begin
    sb.Clear();
    var k := Round(((d - 1) * 100), 2);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    sb.Append(k < 0 ? '-' : (k > 0 ? '+' : ''));
    sb.Append(Math.Abs(k));
    sb.Append(perc_str);
    Result := sb.ToString();
  end;
  sw.Stop;
  Writeln(sw.ElapsedMilliseconds);
end;

begin
  Test1();
  Test2();
  Test3();
  Test4();
  Test5();
  Test6();
end.