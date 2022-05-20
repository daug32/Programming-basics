PROGRAM lw141(INPUT, OUTPUT);
VAR 
	Holder: TEXT;

PROCEDURE Copy(VAR Inp, Out: TEXT);
VAR Ch: CHAR;
BEGIN {Copy}
	WHILE NOT EOLN(Inp) DO
	BEGIN
		READ(Inp, Ch);
		WRITE(Out, Ch)
	END;
	WRITELN(Out)
END; {Copy}

PROCEDURE Split(VAR F1, F2, F3: TEXT);
VAR 
	isEven: BOOLEAN;
	Ch: CHAR;
BEGIN {Split}
	RESET(F1);
	REWRITE(F2);
	REWRITE(F3);
	isEven := TRUE;
	WHILE NOT EOLN(F1)
	DO 
		BEGIN	
			READ(F1, Ch);
			IF isEven 
			THEN WRITE(F2, Ch)
			ELSE WRITE(F3, Ch);
			isEven := NOT isEven
		END		
END; {Split}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
VAR 
	Ch2, Ch3: CHAR;
BEGIN {Merge}
	REWRITE(F1);
	RESET(F2);
	RESET(F3);
	READ(F2, Ch2);
	READ(F3, Ch3);  
	WHILE ((NOT EOLN(F2)) AND (NOT EOLN(F3)))
	DO 
		BEGIN
			IF Ch2 < Ch3
			THEN
				BEGIN
					WRITE(F1, Ch2);
					READ(F2, Ch2)
				END	
			ELSE
				BEGIN
					WRITE(F1, Ch3);
					READ(F3, Ch3)
				END
		END;
	WHILE NOT EOLN(F2)
	DO 
		BEGIN	
			WRITE(F1, Ch2);
			READ(F2, Ch2)
		END;
	WHILE NOT EOLN(F3)
	DO 
		BEGIN	
			WRITE(F1, Ch3);
			READ(F3, Ch3)
		END;
END; {Merge}

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR 
	F2, F3: TEXT;
	Ch: CHAR;
BEGIN {RecursiveSort} 
	RESET(F1);
	IF NOT EOLN(F1)
	THEN
  	BEGIN
			Split(F1, F2, F3);
			RecursiveSort(F2);
			RecursiveSort(F3);
			Merge(F1, F2, F3)		
		END
END; {RecursiveSort}

BEGIN {lw141}
	WRITELN(OUTPUT, 'Program has started');

	REWRITE(Holder); 
	Copy(INPUT, Holder);
	RecursiveSort(Holder);
	RESET(Holder);
	Copy(Holder, OUTPUT);

	WRITELN(OUTPUT, 'Program has finished');	
END.  {lw141}
