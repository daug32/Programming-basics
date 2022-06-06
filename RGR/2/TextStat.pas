UNIT TextStat;
INTERFACE   

PROCEDURE SetMaxContainerSize(Count: INTEGER);
PROCEDURE CollectStat(InpPath, OutPath: STRING); 

IMPLEMENTATION    
USES
  TreeContainer,  
  StringHandler; 
VAR
  MaxContainerSize: INTEGER;
    
PROCEDURE CollectStat(InpPath, OutPath: STRING);
VAR {CollectStat}  
  InpFile, OutFile: TEXT;
  Word: STRING; 
BEGIN    
  ASSIGN(OutFile, OutPath);
  REWRITE(OutFile);
  ASSIGN(InpFile, InpPath);
  RESET(InpFile); 
                     
  {Read words and save them}
  WHILE NOT EOF(InpFile)
  DO 
    BEGIN       
      Word := ReadWord(InpFile);
      
      IF LENGTH(Word) > 0 
      THEN
        InsertWord(ToLower(Word))
      ELSE 
        WRITELN('Oh my...');

      IF GetCount > MaxContainerSize
      THEN
        SaveContainer(OutFile)
    END;
  
  SaveContainer(OutFile);
  CLOSE(OutFile);
  CLOSE(InpFile)  
END; {CollectStat} 

PROCEDURE SetMaxContainerSize(Count: INTEGER);
BEGIN
  IF Count >= 1 
  THEN
    MaxContainerSize := Count
  ELSE 
    WRITELN('Invalid max count of container''s elements: ', Count)
END;
 
BEGIN {TextStat}  
  MaxContainerSize := 20000
END. {TextStat}
