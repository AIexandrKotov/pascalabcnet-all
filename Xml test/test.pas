uses System.Xml;
uses System.Xml.Linq;

{$reference 'System.Xml.dll'}
{$reference 'System.Xml.Linq.dll'}

begin
  var doc := new XmlDocument();
  doc.LoadXml(ReadAllText('test.xml', Encoding.UTF8));
  var xRoot := doc.DocumentElement;
    xRoot.FirstChild.ChildNodes.OfType&<XmlElement>.Select(x -> x.HasChildNodes ? x.ChildNodes.OfType&<XmlElement>.Select(y -> y.GetAttribute('v').ToInteger).Sum + x.GetAttribute('v').ToInteger : x.GetAttribute('v').ToInteger()).ToArray().PrintLines
end.