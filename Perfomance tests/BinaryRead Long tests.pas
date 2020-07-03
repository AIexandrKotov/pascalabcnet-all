program BinaryRead Long tests;

uses System;
uses System.IO;
uses System.Diagnostics;

const filename = 'bytetest.dat';

var
  FirstVariable, SecondVariable: word;
  ThirdVariable: integer;

function ToInt64(x, y: word; length: integer): int64;
begin
  Result := (int64(x) shl 48) + (int64(y) shl 32) + length;
end;

procedure Fill(long: int64);
begin
  FirstVariable := word(long shr 48);
  SecondVariable := word(long shl 16 shr 48);
  ThirdVariable := integer(long);
end;

procedure Start;
begin
  var stream := &File.Create(filename);
  var bw := new BinaryWriter(stream);
  bw.Write(100000000);
  var x := ToInt64(16, 32, 64);
  loop 100000000 do bw.Write(x);
  bw.Dispose();
  stream.Dispose();
end;

procedure Test1;
begin
  var sw := new Stopwatch();
  var stream := &File.OpenRead(filename);
  var br := new BinaryReader(stream);
  sw.Start();
  var count := br.ReadInt32();
  loop count do
  begin
    ThirdVariable := br.ReadInt32();
    SecondVariable := br.ReadInt16();
    FirstVariable := br.ReadInt16();
  end;
  sw.Stop();
  br.Dispose();
  stream.Dispose();
  sw.ElapsedMilliseconds.Println();
end;

procedure Test2;
begin
  var sw := new Stopwatch();
  var stream := &File.OpenRead(filename);
  var br := new BinaryReader(stream);
  sw.Start();
  var count := br.ReadInt32();
  loop count do
  begin
    Fill(br.ReadInt64());
  end;
  sw.Stop();
  br.Dispose();
  stream.Dispose();
  sw.ElapsedMilliseconds.Println();
end;

procedure Test3;
begin
  var sw := new Stopwatch();
  var stream := &File.OpenRead(filename);
  var br := new BinaryReader(stream);
  sw.Start();
  var count := br.ReadInt32();
  var bytes := br.ReadBytes(count * 8);
  for var i := 0 to count - 1 do
  begin
    Fill(BitConverter.ToInt64(bytes, i * 8));
  end;
  sw.Stop();
  br.Dispose();
  stream.Dispose();
  sw.ElapsedMilliseconds.Println();
end;

procedure Test4;
begin
  var sw := new Stopwatch();
  var stream := &File.OpenRead(filename);
  var br := new BinaryReader(stream);
  sw.Start();
  var count := br.ReadInt32();
  var bytes := br.ReadBytes(count * 8);
  for var i := 0 to count - 1 do
  begin
    ThirdVariable := integer(bytes[i]) shl 24 or integer(bytes[i + 1]) shl 16 or integer(bytes[i + 2]) shl 8 or integer(bytes[i + 3]);
    SecondVariable := word(bytes[i + 4]) shl 8 or word(bytes[i + 5]);
    FirstVariable := word(bytes[i + 6]) shl 8 or word(bytes[i + 7]);
  end;
  sw.Stop();
  br.Dispose();
  stream.Dispose();
  sw.ElapsedMilliseconds.Println();
end;

begin
  //warning! создаёт файл на 800 мегабайт
  Start();
  Test1();
  Test2();
  Test3();
  Test4();
end.