PROGRAM List(INPUT, OUTPUT);
TYPE 
	NodePtr = ^Node;
	Node =	RECORD 
				  	Key: CHAR;
						Next: ^Node;
					END;
VAR 
	FirstPtr, NewPtr, Curr, Prev: NodePtr;
	Found: BOOLEAN;     

PROCEDURE Insert;
BEGIN            	
	Curr := FirstPtr;
	IF Curr = NIL
	THEN 
		BEGIN 
			FirstPtr := NewPtr;
			EXIT;
		END;

	WHILE Curr^.Next <> NIL
	DO 
		Curr := Curr^.Next;
	Curr^.Next := NewPtr
END; 

PROCEDURE PrintList;
BEGIN
	Curr := FirstPtr;
	WHILE Curr <> NIL
	DO 
		BEGIN 
				WRITELN(Curr^.Key);
				Curr := Curr^.Next;
		END
END;                                        

BEGIN                                         	
	FirstPtr := NIL;
	WHILE NOT EOLN 
	DO 
		BEGIN 
			NEW(NewPtr);
			READ(NewPtr^.Key);
			Insert;
		END;
	PrintList
END.
