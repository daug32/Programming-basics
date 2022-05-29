PROGRAM GroupWords(INPUT, OUTPUT);
USES
  StatGrouper;
VAR
  InpPath, OutPath: STRING;
BEGIN {GroupWords}
  InpPath := 'Output.txt';
  OutPath := 'GroupedOutput.txt';
  GroupWords(InpPath, OutPath)  
END. {GroupWords}
