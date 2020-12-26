uses System;

type
  BaseClass = abstract class(ICloneable)
    public function Clone(): object; abstract;
  end;
  
  T1 = class(BaseClass)
    public function Clone(): object; override;
    begin
      Result := new T1();
    end;
  end;
  
  T2 = class(BaseClass)
    public function Clone(): object; override;
    begin
      Result := MemberwiseClone();
    end;
  end;
  
  IShell = interface
    function GetBase(): BaseClass;
  end;
  
  T1Shell = class(T1, IShell)
    public function GetBase(): BaseClass;
    begin
      Result := BaseClass(inherited Clone());
    end;
  end;
  
  T2Shell = class(T2, IShell)
    public function GetBase(): BaseClass;
    begin
      Result := BaseClass(inherited Clone());
    end;
  end;

begin
  var sh1 := new T1Shell();
  var sh2 := new T2Shell();
  
  Writeln(sh1.GetBase().GetType().Name);
  Writeln(sh2.GetBase().GetType().Name);
end.