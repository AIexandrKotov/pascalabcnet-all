uses System;
uses System.IO;
uses System.Collections.Generic;
uses System.Linq;

var
  basedirectory := Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + '\GitHub\Biker-3\';
  //basedirectory := 'C:\Users\Kotov\Documents\GitHub\Biker-3\Data\Quests';
  pascalgithubdirectory := 'C:\Users\Kotov\Documents\GitHub\REALpascalabcnet';
  splitters := '&|=!-+*.,;<>[]()@$"''{}#: /\?'#9#10#13.ToCharArray;
  windows1251 := Encoding.GetEncoding(1251);

function StringsCount(dir, mask: string): integer;
begin
  var directories := Directory.GetDirectories(dir);
  foreach var directory in directories do Result += StringsCount(directory, mask);
  Result += EnumerateFiles(dir, mask).Sum(fname->ReadLines(fname, windows1251).Count());
end;

function MostWords(dir, mask: string): Dictionary<string, integer>;
begin
  Result := EnumerateAllFiles(dir, mask).SelectMany(fname -> ReadAllText(fname).ToWords(splitters)).GroupBy(wrd -> wrd).Select(x -> new ValueTuple(x.Key, x.Count)).OrderBy(x -> - x.Item2).ToDictionary(x -> x.Item1, x -> x.Item2);
end;

begin
  StringsCount(basedirectory, '*.cs').Print;
//  var cnt := 0;
//  foreach var str in MostWords(basedirectory, '*.cs') do
//  begin
//    if (str.Key.Length = 1) and (str.Key[1].IsDigit) then continue;
//    cnt += 1;
//    if cnt > 100 then break;
//    Writeln($'Слово ''{str.Key}'' - встречается {str.Value} раз');
//  end;
  readln;
end.