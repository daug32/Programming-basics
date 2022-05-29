UNIT TextStat;
INTERFACE   

PROCEDURE CollectStat(InpPath: STRING);  
PROCEDURE SaveStat(OutPath: STRING);
PROCEDURE SetMaxFileSize(Size: INTEGER);

IMPLEMENTATION    
USES
  TreeContainer,  
  StringHandler;
VAR 
  MaxFileSize, ReadedSymbols: INTEGER;
    
PROCEDURE CollectStat(InpPath: STRING);
VAR {CollectStat}  
  Inp: TEXT;
  Word: STRING; 
BEGIN    
  ASSIGN(Inp, InpPath);
  RESET(Inp);
  
  {Read words and save them}
  WHILE NOT EOF(Inp)
  DO 
    BEGIN       
      Word := ReadWord(Inp, ReadedSymbols, MaxFileSize);  

      IF LENGTH(Word) > 0 
      THEN
        InsertWord(ToLower(Word)); 
      
      {Limiting the count of reading symbols}
      IF (MaxFileSize > 0) AND
         (ReadedSymbols > MaxFileSize)
      THEN  
        EXIT
    END;

  CLOSE(Inp)  
END; {CollectStat} 
 
PROCEDURE SaveStat(OutPath: STRING);
BEGIN {SaveStat}
  SaveContainer(OutPath)
END; {SaveStat} 

PROCEDURE SetMaxFileSize(Size: INTEGER);
BEGIN {SetMaxFileSize}
  MaxFileSize := Size;
END; {SetMaxFileSize}
 
BEGIN {TextStat}  
  ReadedSymbols := 0;
  MaxFileSize := -1;
END. {TextStat}
