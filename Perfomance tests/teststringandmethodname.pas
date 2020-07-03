uses System;
uses System.Diagnostics;

type
  T = static class
    public static KS: Dictionary<string, boolean> := new Dictionary<string, boolean>();

    public static procedure Method := exit;
  end;
  
{$platformtarget x64}

procedure Invoke(reference: string);
begin
  T.KS[reference] := true;
end;

procedure Invoke(act: Action);
begin
  T.KS[act.Method.Name] := true;
end;

begin
  T.KS.Add('Method', false);
  var sw1 := new Stopwatch();
  var sw2 := new Stopwatch();
  var count := 10000000;
  
  sw1.Start();
  loop count do Invoke('Method');
  sw1.Stop();
  
  sw2.Start();
  loop count do Invoke(T.Method);
  sw2.Stop();
  
  Println(sw1.ElapsedTicks / TimeSpan.TicksPerMillisecond);
  Println(sw2.ElapsedTicks / TimeSpan.TicksPerMillisecond);
  Println($'Invoke(string s) быстрее чем Invoke(Action act) в {(sw2.ElapsedTicks / sw1.ElapsedTicks).Round(1)} раз')
end.