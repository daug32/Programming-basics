PROGRAM Prime(INPUT, OUTPUT);
CONST
	MaxNumber = 100;
VAR                          
	i, Bunny: INTEGER;
	Sieve: SET OF 2 .. MaxNumber;   
BEGIN   
	{Init}                
	Sieve := [2 .. MaxNumber];     

	{Process numbers}
	FOR i := 2 TO MaxNumber
	DO 
		BEGIN
			{Skip if number is already crossed out}
			IF NOT (i IN Sieve) THEN CONTINUE;
               	
			{Print simle number}
			WRITE(i, ' ');  

			{Delete repeating numbers}
			Bunny := i;
			WHILE Bunny <= MaxNumber
			DO 
				BEGIN
					Bunny := i * ((Bunny DIV i) + 1); {Repeating number}
					Sieve := Sieve - [Bunny] {Delete the number}
				END;			
		END
END.
