UNIT TreeContainer;
INTERFACE 
                                   
PROCEDURE Init(OutPath: STRING);              

PROCEDURE SaveContainer;
PROCEDURE InsertWord(Word: STRING);
                         
FUNCTION GetCount: INTEGER;             

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
	TempFile, OutFile: TEXT;

{ =======================
  Private methods 
======================== }

PROCEDURE CopyFile(VAR FromFile, ToFile: TEXT);
VAR 
	Str: STRING;
BEGIN {CopyFile}
  WHILE NOT EOF(FromFile)
  DO 
    BEGIN
      READLN(FromFile, Str);
      WRITELN(ToFile, Str)
    END
END; {CopyFile}

PROCEDURE ConstructNode(VAR Element: NodePtr; VAR Word: STRING);
BEGIN
  Count := Count + 1;
  NEW(Element); 
  Element^.Word := Word;
  Element^.Count := 1;
  Element^.LeftTree := NIL;
  Element^.RightTree := NIL
END;   

PROCEDURE SaveTree(Curr: NodePtr; VAR Buffer: Node; VAR BufferInserted: BOOLEAN); 
VAR 
	CurrInserted: BOOLEAN;
  CompareResult: INTEGER;
BEGIN {SaveTree}                                   
  IF Curr^.LeftTree <> NIL
  THEN
    SaveTree(Curr^.LeftTree, Buffer, BufferInserted);
       
  CurrInserted := FALSE;
  WHILE NOT CurrInserted
  DO
    BEGIN
      IF EOF(OutFile)
      THEN 
        BEGIN                               
          WRITELN(TempFile, Curr^.Word, ' ', Curr^.Count);
          CurrInserted := TRUE;
          BREAK
        END;
      
      IF BufferInserted
      THEN
        BEGIN      
          Buffer.Word := ReadWord(OutFile);
					READLN(OutFile, Buffer.Count);
					BufferInserted := FALSE;
        END;
      CompareResult := StringComparer(Curr^.Word, Buffer.Word);

      {Current word goes before this word. So, insert the current}
      IF CompareResult = -1
      THEN 
        BEGIN   
          WRITELN(TempFile, Curr^.Word, ' ', Curr^.Count);
          CurrInserted := TRUE;
          BREAK
        END;
                                         
      {Current word is the same with this word. So, insert them as one}
      IF CompareResult = 0
      THEN 
        BEGIN        
          WRITELN(TempFile, Buffer.Word, ' ', Curr^.Count + Buffer.Count);   
					BufferInserted := TRUE;	
          CurrInserted := TRUE;					                                     
          BREAK
        END;
   
      {CompareReult = 1
      Current word goes after this word. So, insert the previous one}
      WRITELN(TempFile, Buffer.Word, ' ', Buffer.Count);
			BufferInserted := TRUE
    END;

  IF Curr^.RightTree <> NIL
  THEN
    SaveTree(Curr^.RightTree, Buffer, BufferInserted);

  {Both branches are already saved. So, clean that leaf}
  DISPOSE(Curr)
END; {SaveTree}

{ =======================
  Public methods 
======================== }  

PROCEDURE Init(OutPath: STRING);
BEGIN {Init}  
  Count := 0;      
  Head := NIL;
	ASSIGN(OutFile, OutPath);
	REWRITE(OutFile);
END; {Init}
             


FUNCTION GetCount: INTEGER;
BEGIN {GetCount}
  GetCount := Count
END; {GetCount}  



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

                    

PROCEDURE SaveContainer;
VAR
	Buffer: Node; 
	BufferInserted: BOOLEAN;
BEGIN {SaveContainer}                                         
  WRITE('*'); 
   
  RESET(OutFile);
  REWRITE(TempFile);  
  
	Buffer.Word := '';
	Buffer.Count := 0;  
	BufferInserted := TRUE;
  SaveTree(Head, Buffer, BufferInserted);

  Head := NIL;
  Count := 0;

  IF NOT BufferInserted
  THEN 
    WRITELN(TempFile, Buffer.Word, ' ', Buffer.Count);   
                
	CopyFile(OutFile, TempFile);   
  RESET(TempFile);
  REWRITE(OutFile);
	CopyFile(TempFile, OutFile);

  WRITELN('+')
END; {SaveContainer}

BEGIN {TreeContainer}  
END. {TreeContainer}
