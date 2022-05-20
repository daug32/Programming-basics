PROGRAM Lw17_ReadNumber_Test(INPUT, OUTPUT);
VAR Holder: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR N: INTEGER);
VAR Ch: CHAR;
BEGIN {ReadDigit}
	N := -1;
	IF NOT EOLN(F) 
	THEN 
		BEGIN 
			READ(F, Ch);
			IF Ch = '0' THEN N := 0 ELSE
			IF Ch = '1' THEN N := 1 ELSE
			IF Ch = '2' THEN N := 2 ELSE
			IF Ch = '3' THEN N := 3 ELSE
			IF Ch = '4' THEN N := 4 ELSE
			IF Ch = '5' THEN N := 5 ELSE
			IF Ch = '6' THEN N := 6 ELSE
			IF Ch = '7' THEN N := 7 ELSE
			IF Ch = '8' THEN N := 8 ELSE
			IF Ch = '9' THEN N := 9   
		END
END; {ReadDigit}

PROCEDURE ReadNumber(VAR Inp: TEXT; VAR Result: INTEGER);
VAR 
	Ch: CHAR;
	Digit, MaxNumber: INTEGER;
BEGIN {ReadNumber}
	ReadDigit(Inp, Digit);
	Result := Digit;
	MaxNumber := 255;

	WHILE Digit > -1
	DO 
		BEGIN
			ReadDigit(Inp, Digit);
			IF Digit > -1
			THEN
				BEGIN
					IF(Result <= (MaxNumber - Digit) DIV 10)
					THEN Result := Result * 10 + Digit
					ELSE Result := -2
				END
		END
	
END; {ReadNumber}

BEGIN {Lw17_ReadNumber_Test}
	ReadNumber(INPUT, Holder);
	WRITELN(Holder)	
END. {Lw17_ReadNumber_Test}
