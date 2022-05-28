UNIT TextStat;
INTERFACE   

PROCEDURE CollectStat(InpPath: STRING);  
PROCEDURE SaveStat(OutPath: STRING);

IMPLEMENTATION    
USES 
  StringHandler, 
  TreeContainer;
VAR
  Inp: FILE OF CHAR;

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
    READ(Inp, Ch);

  WHILE IsWord AND (NOT EOF(Inp)) 
  DO 
    BEGIN                   
      PrevCh := Ch;
      READ(Inp, Ch);
      IsWord := IsWordChar(Ch);

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
END. {TextStat}
