PROGRAM CountWords(INPUT, OUTPUT); 
USES
  StringHandler,
  TextStat;
VAR 
  Some: TEXT;
  InpPath, OutPath: STRING;

FUNCTION ParseString(VAR InpStr: STRING) : STRING;
VAR                
  Word: STRING;               
  PrevCh, Ch: CHAR;
  I, Len: INTEGER;
  IsWord: BOOLEAN;
BEGIN
  WRITELN(InpStr);
  Ch := ' ';    
  Word := '';
  PrevCh := ' ';
  Len := LENGTH(InpStr);
  I := Len;

  WHILE (I > 0) AND (NOT IsLetter(InpStr[I]))
  DO
    I := I - 1;

  IsWord := TRUE;
  WHILE IsWord
  DO
    BEGIN
      IF I < 1
      THEN
        BEGIN
          ParseString := Ch + Word;
        END;

      Ch := InpStr[I];
      InpStr[I] := ' ';
      I := I - 1;

      Word := Ch + Word;

      WRITELN(Ch);

      IsWord := IsLetter(Ch);
    END;

  ParseString := Word;  
END;

BEGIN 
  {
  WRITELN('Put the path for the INPUT file');
  READLN(InpPath);                            
  WRITELN('Put the path for the OUTPUT file');
  READLN(OutPath);    
  }
  InpPath := 'Dictionary.txt';
  OutPath := 'Output.txt';
  SetMaxContainerSize(40000);
  
  WRITELN('Collecting stat...');
  CollectStat(InpPath, OutPath);
  WRITELN('Done!') 
  
  {
  ASSIGN(Some, 'Input.txt');
  RESET(Some); 

  WHILE NOT EOF(Some)
  DO
    BEGIN
      WRITELN('Reading');
      READLN(Some, InpPath);       
      OutPath := ' ';
      WHILE LENGTH(OutPath) > 0
      DO 
        BEGIN              
          OutPath := ParseString(InpPath);               
          WRITELN(':', OutPath, ':');
        END;           
    END
  }
END.


