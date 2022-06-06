UNIT TreeContainer;
INTERFACE 
                           
PROCEDURE Clear;                   
FUNCTION GetCount: INTEGER;
PROCEDURE InsertWord(Word: STRING);
PROCEDURE SaveContainer(VAR OutFile: TEXT);

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
  Count: INTEGER; 

{ =======================
  Private methods 
======================== }

PROCEDURE ConstructNode(VAR Element: NodePtr; VAR Word: STRING);
BEGIN
  Count := Count + 1;
  NEW(Element); 
  Element^.Word := Word;
  Element^.Count := 1;
  Element^.LeftTree := NIL;
  Element^.RightTree := NIL
END;   

PROCEDURE CollapseTree(Curr: NodePtr);
BEGIN {CollapseTree} 
  IF Curr^.LeftTree <> NIL
  THEN
    CollapseTree(Curr^.LeftTree);
  IF Curr^.RightTree <> NIL
  THEN
    CollapseTree(Curr^.RightTree);   
  Dispose(Curr)
END; {CollapseTree}   

{ =======================
  Public methods 
======================== }  
    
FUNCTION GetCount: INTEGER;
BEGIN {GetCount}
  GetCount := Count
END; {GetCount}

PROCEDURE Clear;
BEGIN {Clear} 
  CollapseTree(Head); 
  Head := NIL;
  Count := 0
END; {Clear} 

PROCEDURE InsertWord(Word: STRING);
VAR   
  Prev, Curr: NodePtr;               
  Comparing: INTEGER;  
BEGIN {SaveElement} 
  {If the container is empty}
  IF Head = NIL
  THEN
    BEGIN 
      ConstructNode(Head, Word);   
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
      {Given word already exists, 
      So increase it's count and return}
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

  {Construct new leaf} 
  ConstructNode(Curr, Word); 
  IF Comparing = -1
  THEN
    Prev^.LeftTree := Curr
  ELSE
    Prev^.RightTree := Curr
END; {SaveElement}                       

PROCEDURE SaveContainer(VAR OutFile: TEXT);
VAR             
  Word: STRING; 
  TempFile: TEXT;  
  CompareResult, WordCount: INTEGER;

PROCEDURE SaveTree(Curr: NodePtr);
VAR                                                       
  IsInserted: BOOLEAN;   
BEGIN {SaveTree}                                   
  IF Curr^.LeftTree <> NIL
  THEN
    SaveTree(Curr^.LeftTree);
       
  {It is used for semantical indication of the insertion. 
  Can be replaced by IF TRUE condition}
  IsInserted := FALSE;

  WHILE NOT IsInserted 
  DO
    BEGIN
      IF EOF(OutFile)
      THEN 
        BEGIN                               
          WRITELN(TempFile, Curr^.Word, ' ', Curr^.Count);
          IsInserted := TRUE;
          BREAK
        END;
      
      {It will run if we had inserted the word}
      IF Word = ''
      THEN
        BEGIN
          Word := ReadWord(OutFile);
          WordCount := ReadInt(OutFile)
        END;
      CompareResult := StringComparer(Curr^.Word, Word);

      {Current word goes before this word. So, insert the current}
      IF CompareResult = -1
      THEN 
        BEGIN   
          WRITELN(TempFile, Curr^.Word, ' ', Curr^.Count);
          IsInserted := TRUE;
          BREAK
        END;
                                         
      {Current word is the same with this word. So, insert them as one}
      IF CompareResult = 0
      THEN 
        BEGIN        
          WordCount := Curr^.Count + WordCount;
          WRITELN(TempFile, Word, ' ', WordCount); 
          IsInserted := TRUE;
          Word := '';
          BREAK
        END;
   
      {CompareReult = 1
      Current word goes after this word. So, insert the previous one}
      WRITELN(TempFile, Word, ' ', WordCount);
      Word := ''
    END;

  IF Curr^.RightTree <> NIL
  THEN
    SaveTree(Curr^.RightTree);

  {Both branches are already saved. So, clean that leaf}
  DISPOSE(Curr)
END; {SaveTree}

BEGIN {SaveContainer} 
  Word := '';        
  CompareResult := 0;                                          
  RESET(OutFile);
  REWRITE(TempFile); 

  {Clean the tree and 
  Merge virtual container and the output file into temp file} 
  WRITE('1');
  SaveTree(Head);
  WRITE('2');

  {In this case last Word wasn't written yet}
  IF CompareResult = -1
  THEN 
    WRITELN(TempFile, Word, ' ', WordCount);

  {Finish the cleaning}
  Head := NIL;
  Count := 0;

  {Copy elements that wasn't copied yet}   
  WHILE NOT EOF(OutFile)
  DO 
    BEGIN
      READLN(OutFile, Word);
      WRITELN(TempFile, Word);
    END; 
               
  {Save data to the main file}
  RESET(TempFile);
  REWRITE(OutFile);
  WHILE NOT EOF(TempFile)
  DO 
    BEGIN
      READLN(TempFile, Word);
      WRITELN(OutFile, Word)
    END;

  WRITELN('3')
END; {SaveContainer}

BEGIN {TreeContainer}  
  Head := NIL;
  Count := 0
END. {TreeContainer}
