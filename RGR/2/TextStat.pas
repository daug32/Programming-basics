UNIT TextStat;
INTERFACE   

PROCEDURE CollectStat(InpPath: STRING);  
PROCEDURE SaveStat(OutPath: STRING);

IMPLEMENTATION    
USES  
  StringHandler;
TYPE
  NodePtr = ^Node; 
  Node =  RECORD 
            Word: STRING;
            Count: INTEGER;
            LeftTree: NodePtr;
            RightTree: NodePtr
          END; 
VAR 
  Head: NodePtr;

PROCEDURE ContructNode(VAR Element: NodePtr; VAR Word: STRING);
BEGIN
  NEW(Element); 
  Element^.Word := Word;
  Element^.Count := 1;
  Element^.LeftTree := NIL;
  Element^.RightTree := NIL
END;

PROCEDURE InsertWord(Word: STRING);
VAR   
  Prev, Curr: NodePtr;               
  Comparing: INTEGER;  
BEGIN {SaveElement} 
  {If the container is empty}
  IF Head = NIL
  THEN
    BEGIN 
      ContructNode(Head, Word);   
      EXIT
    END; 
                              
  {Init}
  Prev := NIL;
  Curr := Head;  
  
  {Insert word with sorting}
  WHILE Curr <> NIL
  DO
    BEGIN
      Comparing := StringComparer(Word, Curr^.Word); 
      {Given word already exists, so 
      increase it's count and return}
      IF Comparing = 0
      THEN
        BEGIN
          Curr^.Count := Curr^.Count + 1;
          EXIT
        END;
          
      {Given word is less than the node's word}
      IF Comparing = -1
      THEN
        BEGIN   
          Prev := Curr;
          Curr := Curr^.LeftTree
        END;      

      {Given word is greater than the node's word}         
      IF Comparing = 1
      THEN      
        BEGIN
          Prev := Curr;
          Curr := Curr^.RightTree
        END
    END;

  {Construct new leaf} 
  ContructNode(Curr, Word); 
  IF Comparing = -1
  THEN
    Prev^.LeftTree := Curr
  ELSE
    Prev^.RightTree := Curr
END; {SaveElement}
    
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
      Word := ReadWord(Inp);  
      IF LENGTH(Word) > 0 
      THEN
        InsertWord(ToLower(Word)) 
    END;                         
  CLOSE(Inp)  
END; {CollectStat} 
 
PROCEDURE SaveStat(OutPath: STRING);
VAR 
  OutFile: TEXT;

PROCEDURE SaveTree(Curr: NodePtr);
BEGIN {SaveTree}                                   
  IF Curr^.LeftTree <> NIL
  THEN
    SaveTree(Curr^.LeftTree);
  WRITELN(OutFile, Curr^.Word, ' ', Curr^.Count);
  IF Curr^.RightTree <> NIL
  THEN
    SaveTree(Curr^.RightTree)
END; {SaveTree}

BEGIN {SaveStat}
  ASSIGN(OutFile, OutPath); 
  REWRITE(OutFile);
  SaveTree(Head);
  CLOSE(OutFile)
END; {SaveStat} 
 
BEGIN {TextStat}  
  Head := NIL
END. {TextStat}
