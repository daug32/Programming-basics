PROGRAM MergeSort(INPUT, OUTPUT);
VAR
	Holder: TEXT;
	Ch: CHAR;

PROCEDURE CopyFile(VAR Inp, Out: TEXT);
VAR Ch: CHAR;
BEGIN
	WHILE NOT EOLN(Inp)
	DO
		BEGIN
			READ(Inp, Ch);
			WRITE(Out, Ch)
		END
END;

PROCEDURE Split(VAR F1, F2, F3: TEXT);
VAR
  Ch: CHAR;
	Switch: BOOLEAN;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
	Switch := TRUE;
  WHILE NOT EOLN(F1)
  DO
    BEGIN
	  	READ(F1, Ch);
	  	IF (Switch)
	  	THEN WRITE(F2, Ch)
	  	ELSE WRITE(F3, Ch);
			Switch := NOT(Switch)
		END;
  WRITELN(F2);
  WRITELN(F3)  
END; {Split}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
VAR
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
	IF NOT EOLN(F2) THEN READ(F2, Ch2);
  IF NOT EOLN(F3) THEN READ(F3, Ch3);
  WHILE NOT(EOLN(F2)) AND NOT(EOLN(F3))
  DO
    BEGIN
	  	IF Ch2 < Ch3
		  THEN
		    BEGIN
			  	WRITE(F1, Ch2);
			  	READ(F2, Ch2);
				END            
		  ELSE
		    BEGIN
			  	WRITE(F1, Ch3);
			  	READ(F3, Ch3)
				END
		END;
	IF NOT EOLN(F2) THEN WRITE(F1, Ch2);
	CopyFile(F2, F1);
	IF NOT EOLN(F3) THEN WRITE(F1, Ch3);
	CopyFile(F3, F1);
	WRITELN(F1);
END; {Merge}

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR
  F2, F3: TEXT;
  Ch: CHAR;
BEGIN {RecursiveSort}
  RESET(F1);
  IF NOT EOLN(F1) AND NOT EOF(F1)
  THEN
    BEGIN
	  	Split(F1, F2, F3);
	  	RecursiveSort(F2);
	  	RecursiveSort(F3);
	  	Merge(F1, F2, F3)
		END
END; {RecursiveSort}

BEGIN {MergeSort}
	REWRITE(Holder);
	CopyFile(INPUT, Holder);
  RecursiveSort(INPUT); 
	RESET(Holder);
	CopyFile(Holder, OUTPUT);
END. {MergeSort}
