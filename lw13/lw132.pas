PROGRAM WordsComparer(INPUT, OUTPUT);
VAR        
	F1, F2: TEXT;
	Continue, Ch: CHAR;

PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
{Result 0, 1, 2 если лексикографический порядок F1 <, =, > чем F2
соответственно. Фактические параметры, соответствующие F1 и F2, 
должны быть различными}
VAR
  Ch1, Ch2: CHAR;
BEGIN {Lexico}  
	RESET(F1);
	RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1) AND NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF (Ch1 < Ch2) OR (EOLN(F1) AND NOT EOLN(F2))
      THEN {Ch1 < Ch2 или F1 короче F2}
        Result := '1'
      ELSE
        IF (Ch1 > Ch2) OR (NOT EOLN(F1) AND EOLN(F2))
        THEN {Ch1 > Ch2 или F2 короче F1}
					Result := '2'
    END
END; {Lexico}

PROCEDURE CopyFile(VAR F1, F2: TEXT);
VAR 
	Ch: CHAR;
BEGIN {CopyFile}
	WHILE NOT EOLN(F1)
	DO 
		BEGIN
			READ(F1, Ch);  
			WRITE(F2, Ch)
		END;
	WRITELN(F2)
END; {CopyFile}

BEGIN {WordsComparer}  
	WRITE('First word: ');
	REWRITE(F1);
	CopyFile(INPUT, F1);

	WRITE('Second word: ');
	RESET(INPUT);
	REWRITE(F2);
	CopyFile(INPUT, F2);

	Lexico(F1, F2, Ch);
	WRITE('Result of comparing: ', Ch)
END. {WordsComparer}

