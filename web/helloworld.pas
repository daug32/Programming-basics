PROGRAM HelloWeb(INPUT, OUTPUT);

PROCEDURE Copy(VAR Inp, Out: TEXT);
VAR Ch: CHAR;
BEGIN
	WHILE NOT EOF(Inp)
	DO 
		BEGIN
			READ(Inp, Ch);
			WRITE(Out, Ch);
		END
END;

BEGIN
	WRITELN('Content-Type: text/plain');
	WRITELN;
	WRITELN('Hello, web!');
	Copy(INPUT, OUTPUT);
	WRITELN('End');
END.
