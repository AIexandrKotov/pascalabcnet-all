uses System;
uses System.Diagnostics;

function ToEnum<T>(self: string): T; extensionmethod; where T: Enum;
begin
  Result := T(Enum.Parse(typeof(T), self));
end;

begin
  var sw1 := new Stopwatch();
  var sw2 := new Stopwatch();
  sw1.Start();
  loop 10000000 do
  begin
    var __ := ConsoleColor(Enum.Parse(typeof(ConsoleColor), 'Black'));
  end;
  sw1.Stop();
  sw2.Start();
  loop 10000000 do
  begin
    var __ := 'Black'.ToEnum&<ConsoleColor>();
  end;
  sw2.Stop();
  sw1.ElapsedMilliseconds.Println;
  sw2.ElapsedMilliseconds.Println;
end.