uses System;
uses System.Diagnostics;
uses System.Threading;

type
  T = class
    static field: Dictionary<string, boolean>;
    
    static current_ups: TimeSpan;
    static procedure SetUps(ups: integer);
    begin
      if ups = -1 then current_ups := TimeSpan.Zero
      else current_ups := new Timespan(Round(1 * Timespan.TicksPerSecond / ups));
    end;
    
    static procedure Threadnulizer();
    begin
      field['100'] := false;
      field['101'] := false;
      field['102'] := false;
      field['103'] := false;
      field['104'] := false;
      field['105'] := false;
      Thread.Sleep(current_ups);
    end;
    
    static constructor();
    begin
      field := new Dictionary<string, boolean>();
      SetUps(60);
      
      field.Add('100', false);
      field.Add('101', false);
      field.Add('102', false);
      field.Add('103', false);
      field.Add('104', false);
      field.Add('105', false);
      
      var th := new Thread(Threadnulizer);
      th.Start();
    end;
    
    static procedure CallMethod(k: byte; s: string; k1: byte);
    begin
      if (k = k1) then field[s] := true;
    end;
    
    static procedure CallMethod(k: byte; s: string; k1, k2: byte);
    begin
      if (k = k1) or (k = k2) then field[s] := true;
    end;
    
    static procedure CallMethod(k: byte; s: string; k1, k2, k3: byte);
    begin
      if (k = k1) or (k = k2) or (k = k3) then field[s] := true;
    end;
    
    static procedure Method1(k: byte);
    begin
      if (k = 100) then field['100'] := true;
      if (k = 101) then field['101'] := true;
      if (k = 102) or (k = 201) then field['102'] := true;
      if (k = 103) or (k = 202) then field['103'] := true;
      if (k = 104) or (k = 128) or (k = 203) then field['104'] := true;
      if (k = 105) or (k = 129) or (k = 204) then field['105'] := true;
    end;
    
    static procedure Method2(k: byte);
    begin
      CallMethod(k, '100', 100);
      CallMethod(k, '101', 101);
      CallMethod(k, '102', 102, 201);
      CallMethod(k, '103', 103, 202);
      CallMethod(k, '104', 104, 128, 203);
      CallMethod(k, '105', 105, 129, 204);
    end;
    
    static procedure CacheExcept();
    begin
      for var i := 0 to 255 do
        Method1(i);
      for var i := 0 to 255 do
        Method2(i);
    end;
    
    static procedure Test(ups: integer);
    begin
      if ups > -1 then $'- UPS {ups}'.Println() else $'- UPS UNLOCKED'.Println();
      SetUps(ups);
      var sw1 := new Stopwatch();
      var sw2 := new Stopwatch();
      
      sw1.Start();
      loop 100000 do
        for var i := 0 to 255 do Method1(i);
      sw1.Stop();
      $'Direct : {sw1.ElapsedMilliseconds}'.Println;
      
      sw2.Start();
      loop 100000 do
        for var i := 0 to 255 do Method2(i);
      sw2.Stop();
      $'Call   : {sw2.ElapsedMilliseconds}'.Println;
    end;

  end;
  
begin
  T.Test(30);
  T.Test(60);
  T.Test(120);
  T.Test(-1);
end.