PROGRAM CountWords(INPUT, OUTPUT); 
USES 
  TextStat;
BEGIN                     
  WRITELN('Collecting stat...');
  CollectStat('Input.txt');
  WRITELN('Collected!');      

  WRITELN('Saving...');
  SaveStat('Output.txt');
  WRITELN('Saved!');
END.
