PROGRAM CountWords(INPUT, OUTPUT); 
USES 
  TextStat;
VAR 
  InpPath, OutPath: STRING;
BEGIN                     
  {
  WRITELN('Put the path for the INPUT file');
  READLN(InpPath);                            
  WRITELN('Put the path for the OUTPUT file');
  READLN(OutPath);
  }
  
  InpPath := 'Dictionary.txt';
  OutPath := 'Output.txt';

  SetMaxFileSize(-1);

  WRITELN('Collecting stat...');
  CollectStat(InpPath);
  WRITELN('Saving...');
  SaveStat(OutPath);
  WRITELN('Done!')
END.
