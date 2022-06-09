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
	TreeContainer.Init(OutPath);

  ASSIGN(InpFile, InpPath);
  RESET(InpFile); 
                     
  {Read words and save them}
  WHILE NOT EOF(InpFile)
  DO 
    BEGIN       
      Word := ReadWord(InpFile);
      
      IF LENGTH(Word) > 0 
      THEN
        InsertWord(ToLower(Word));

      IF GetCount > MaxContainerSize
      THEN
        SaveContainer
    END;
  
  SaveContainer;
  CLOSE(InpFile)  
END; {CollectStat} 



PROCEDURE SetMaxContainerSize(Count: INTEGER);
BEGIN {SetMaxContainerSize}
  IF Count >= 1 
  THEN
    MaxContainerSize := Count
  ELSE 
    WRITELN('Invalid max count of container''s elements: ', Count)
END; {SetMaxContainerSize}
 


BEGIN {TextStat}  
  MaxContainerSize := 20000
END. {TextStat}
