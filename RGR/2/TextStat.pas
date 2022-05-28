UNIT TextStat;
INTERFACE   

PROCEDURE CollectStat(InpPath: STRING);  
PROCEDURE SaveStat(OutPath: STRING);
PROCEDURE SetFileMaxSize(NewSize: INTEGER);

IMPLEMENTATION    
USES 
  StringHandler, 
  TreeContainer;
VAR
  Inp: FILE OF CHAR;
  MaxFileSize, ReadedCount: INTEGER;

PROCEDURE SetFileMaxSize(NewSize: INTEGER);
BEGIN {SetFileMaxSize}
  MaxFileSize := NewSize
END; {SetFileMaxSize}

FUNCTION ReadWord : STRING;
VAR
  Ch, PrevCh: CHAR;
  Word: STRING;  
  IsWord: BOOLEAN;
BEGIN {ReadWord}  
  Ch := ' ';      
  PrevCh := ' ';    
  Word := '';
  IsWord := TRUE;

  WHILE (NOT IsWordChar(Ch)) AND (NOT EOF(Inp))
  DO
    BEGIN   
      READ(Inp, Ch);

      {Limiting the file size}
      IF MaxFileSize > 0 
      THEN
        BEGIN
          ReadedCount := ReadedCount + 1;
          IF ReadedCount > MaxFileSize
          THEN
            EXIT
        END;
    END;

  WHILE IsWord AND (NOT EOF(Inp)) 
  DO 
    BEGIN                   
      PrevCh := Ch;
      READ(Inp, Ch);
      IsWord := IsWordChar(Ch);

      {Limiting the file size}
      IF MaxFileSize > 0 
      THEN
        BEGIN
          ReadedCount := ReadedCount + 1;
          IF ReadedCount > MaxFileSize
          THEN
            EXIT
        END;

      {This willn't save words like this 
      'some-' with '-' at the end}
      IF IsWord OR (PrevCh <> '-')
      THEN          
        Word := Word + PrevCh;

      IsWord := IsWord OR (Ch = '-');
    END;
  
  ReadWord := Word
END; {ReadWord}
    
PROCEDURE CollectStat(InpPath: STRING);
VAR {CollectStat}
  Word: STRING; 
BEGIN
  ASSIGN(Inp, InpPath);  
  RESET(Inp);
  
  {read words and save them}
  WHILE NOT EOF(Inp)
  DO 
    BEGIN       
      Word := ReadWord;
  
      {Limiting the file size}
      IF (MaxFileSize > 0) AND
         (ReadedCount > MaxFileSize)
      THEN
        EXIT;
  
      IF LENGTH(Word) > 0 
      THEN
        InsertWord(ToLower(Word))
    END;

  CLOSE(Inp)  
END; {CollectStat} 
   
PROCEDURE SaveStat(OutPath: STRING);
VAR
  OutFile: FILE OF CHAR;
BEGIN {SaveStat}
  SaveConatiner(OutPath);
END; {SaveStat}           
 
BEGIN {TextStat} 
  MaxFileSize := -1;
  ReadedCount := 0;
END. {TextStat}
