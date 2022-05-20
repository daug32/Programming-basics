PROGRAM Stat(INTPUT, OUTPUT);
USES
	IntegerIO;
VAR 
	MaxNum, MinNum: INTEGER; 
	Average, Holder: INTEGER;
	Holder, NumbersCount: INTEGER;

BEGIN {Stat}
	NumbersCount := 0;

	WHILE TRUE
	DO 
		BEGIN
			WRITELN('Enter number:');
			ReadNumber(Holder);
			IF Holder < 0 THEN BREAK;

			IF Holder < MinNum THEN MinNum := Holder; 
			ELSE IF Holder > MaxNum THEN MaxNum := Holder;
			NumbersCount := NumbersCount + 1;
	END;

	WRITELN('Stats:');
	WRITELN('    Count of numbers: ', NumbersCount);
			
END. {Stat}
