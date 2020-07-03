uses System;
uses System.Diagnostics;
uses System.Threading;
uses System.Threading.Tasks;

type
  Test = static class
    public static A: array of integer := new integer[100000000];
    public static B: array of real    := new real   [100000000];
    
    public static function fnc(x: integer): real := x;
    
    public static procedure Cycle1(i: integer);
    begin
      B[i] := fnc(A[i]);
    end;
    
    public static procedure DoIt();
    begin
      var sw1 := new Stopwatch();
      var sw2 := new Stopwatch();
      
      sw1.Start();
      for var i := 0 to A.Length - 1 do
        B[i] := fnc(A[i]);
      sw1.Stop();
      
      sw2.Start();
      Parallel.For(0, A.Length - 1, Cycle1);
      sw2.Stop();
      
      Writeln(sw1.ElapsedMilliseconds);
      Writeln(sw2.ElapsedMilliseconds);
    end;
  end;

begin
  Test.DoIt();
end.