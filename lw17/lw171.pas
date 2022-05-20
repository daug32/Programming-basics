PROGRAM SumOfDigits(INPUT, OUTPUT);
USES 
	IntegerIO;
VAR 
	Holder, Sum: INTEGER;

BEGIN {SumOfDigits}
	Sum := 0;			
	Holder := 0;
	WHILE (NOT EOLN) AND (Holder > -1) 
	DO 
		BEGIN
			ReadDigit(INPUT, Holder);
			IF Holder > -1 
			THEN 
				Sum := Sum + Holder
		END;
	WRITELN(Sum)
END. {SumOfDigits}
