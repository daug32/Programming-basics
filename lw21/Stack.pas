UNIT Stack;
INTERFACE 
CONST 
	StackSize = 20;
             
PROCEDURE InitStack;    
                                  
FUNCTION GetTop : Char;
PROCEDURE Push(Ch: CHAR);
PROCEDURE Pop(VAR Ch: CHAR); 

FUNCTION IsFull : BOOLEAN;        
FUNCTION IsEmpty : BOOLEAN;       

IMPLEMENTATION
VAR 
	Stack: ARRAY [1 .. StackSize] OF CHAR;
	Top: 1 .. StackSize;
  
PROCEDURE InitStack;
VAR I: INTEGER;
BEGIN {InitStack}
	FOR I := 1 TO StackSize 
	DO 
		Stack[I] = ' '
END; {InitStack}
 
PROCEDURE Pop(VAR Ch: CHAR);
BEGIN {Pop}
	Ch := Stack[Top];
	Top := Top - 1
END; {Pop}   
            
PROCEDURE Push(Ch: CHAR);
BEGIN {Push}
	Top := Top + 1;
	Stack[Top] := Ch
END; {Push} 
		
FUNCTION IsFull : BOOLEAN; 
BEGIN {IsFull}
	IsFull := (Top = StackSize)
END; {IsNull}
   
FUNCTION IsEmpty : BOOLEAN; 
BEGIN {IsEmpty}
	IsEmpty := (Top = 0)
END; {IsEmpty}
       
FUNCTION GetTop : Char;
BEGIN {GetTop}
	GetTop := Stack[Top]
END; {GetTop}

BEGIN {Stack}
	InitStack
END. {Stack}
