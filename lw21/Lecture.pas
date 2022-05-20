PROGRAM Lecture(INPUT, OUTPUT); 
USES Stack; 

PROCEDURE PopStackIntoConsole;
VAR Ch: CHAR;
BEGIN 
	FOR I := 1 TO StackSize
	DO 
		BEGIN
			Pop(Ch);
			WRITELN(I, ': ', Ch)
		END
END;

PROCEDURE PushStackFromConsole;
BEGIN 
	FOR I := 1 TO StackSize 
	DO 
		BEGIN 
			READ(Ch);
			Push(Ch)
		END
END;
   
BEGIN
	PopStackIntoConsole;
	PushStackFromConsole;
	PopStackIntoConsole	
END.
