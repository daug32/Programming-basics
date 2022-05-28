PROGRAM CountWords(INPUT, OUTPUT); 
USES 
  TextStat;
VAR 
  InpPath, OutPath: STRING;
BEGIN                     
  WRITELN('Put the path for the INPUT file');
  READLN(InpPath);                            
  WRITELN('Put the path for the OUTPUT file');
  READLN(OutPath);

  WRITELN('Collecting stat...');
  CollectStat(InpPath);
  WRITELN('Collected!');      

  WRITELN('Saving...');
  SaveStat(OutPath);
  WRITELN('Saved!');
END.
