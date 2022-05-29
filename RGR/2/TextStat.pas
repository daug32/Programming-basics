UNIT TextStat;
INTERFACE   

PROCEDURE CollectStat(InpPath: STRING);  
PROCEDURE SaveStat(OutPath: STRING);

IMPLEMENTATION    
USES 
  StringHandler, 
  TreeContainer;
    
PROCEDURE CollectStat(InpPath: STRING);
VAR {CollectStat}
  Word: STRING;  
  Inp: TEXT;
BEGIN    
  ASSIGN(Inp, InpPath);
  RESET(Inp);
  
  {Read words and save them}
  WHILE NOT EOF(Inp)
  DO 
    BEGIN       
      Word := ReadWord(Inp);
  
      IF LENGTH(Word) > 0 
      THEN
        InsertWord(ToLower(Word))
    END;

  CLOSE(Inp)  
END; {CollectStat} 
   
PROCEDURE SaveStat(OutPath: STRING);
BEGIN {SaveStat}
  SaveConatiner(OutPath);
END; {SaveStat}           
 
BEGIN {TextStat} 
END. {TextStat}
