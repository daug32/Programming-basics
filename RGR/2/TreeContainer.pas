UNIT TreeContainer;
INTERFACE

PROCEDURE InsertWord(Word: STRING);
PROCEDURE SaveConatiner(OutPath: STRING);

IMPLEMENTATION
USES 
  StringHandler;
TYPE
  NodePtr = ^Node; 
  Node =  RECORD 
            Word: STRING;
            Count: INTEGER;
            LeftTree: NodePtr;
            RightTree: NodePtr;
          END; 
VAR 
  Head: ^Node;

PROCEDURE InsertWord(Word: STRING);
VAR   
  Prev, Curr: ^Node;               
  Comparing: INTEGER; 
BEGIN {SaveElement} 
  {If the container is empty}
  IF Head = NIL
  THEN
    BEGIN 
      NEW(Head);   
      Head^.Word := Word;
      Head^.Count := 1;
      Head^.LeftTree := NIL;
      Head^.RightTree := NIL;
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
          Curr := Curr^.LeftTree;
          CONTINUE
        END;  
                                                               
      {Given word is greater than the node's word}         
      Prev := Curr;
      Curr := Curr^.RightTree
    END;
  
  {Construct new node}
  NEW(Curr);
  Curr^.Word := Word;
  Curr^.Count := 1; 
  Curr^.LeftTree := NIL;
  Curr^.RightTree := NIL;                     

  {Set pointer of the previous node to the current one}
  IF Comparing = -1
  THEN
    Prev^.LeftTree := Curr
  ELSe
    Prev^.RightTree := Curr;
END; {SaveElement}

PROCEDURE SaveConatiner(OutPath: STRING);
VAR 
  OutFile: TEXT;

PROCEDURE SaveTree(Curr: NodePtr);
BEGIN                                    
  IF Curr^.LeftTree <> NIL
  THEN
    SaveTree(Curr^.LeftTree);
  WRITELN(OutFile, Curr^.Word, ' ', Curr^.Count);
  IF Curr^.RightTree <> NIL
  THEN
    SaveTree(Curr^.RightTree)
END;

BEGIN
  ASSIGN(OutFile, OutPath); 
  REWRITE(OutFile);
  SaveTree(Head);
  CLOSE(OutFile)
END;

BEGIN {TreeContainer}
  Head := NIL;
END. {TreeContainer}
