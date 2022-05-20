UNIT SymbolsDrawer;
INTERFACE 

PROCEDURE PrintSymbol(Symbol: CHAR);
PROCEDURE PrintSymbolFromFile(Inp: TEXT);
                
IMPLEMENTATION
USES 
	IntegerIO;
CONST 
	MaxSymbols = 25;
	SymbolsInRow = 5;
TYPE
	SymbolSetType = SET OF 1 .. 25;	

PROCEDURE PrintBySet(Symbol: SymbolSetType);
VAR 
	I: INTEGER;
BEGIN {PrintBySet}
	FOR I := 1 TO MaxSymbols
	DO 
		BEGIN
			IF I IN Symbol 
			THEN 
				WRITE('X')
			ELSE 
				WRITE(' ');
			IF ((I MOD SymbolsInRow) = 0) 
			THEN 
				WRITELN
		END;
END; {PrintBySet}

PROCEDURE PrintSymbol(Symbol: CHAR); 
VAR
	SymbolSet: SymbolSetType;
BEGIN {PrintSymbol}                     
	CASE (Symbol) OF 
		'A': SymbolSet := [3, 
											7, 9, 
											12, 14, 
											17, 18, 19, 
											21, 25]; 
		'B': SymbolSet := [1, 2, 3, 4, 
											6, 9, 
											11, 12, 13, 
											16, 19, 
											21, 22, 23, 24];
		'M': SymbolSet := [1, 5, 
											6, 7, 9, 10, 
											11, 13, 15, 
											16, 20, 21, 25];
		ELSE SymbolSet := [1, 2, 3, 4, 5, 
											6, 7, 8, 9, 10, 
											11, 12, 13, 14, 15, 
											16, 17, 18, 19, 20, 
											21, 22, 23, 24, 25]
	END;
	PrintBySet(SymbolSet)
END; {PrintSymbol}

PROCEDURE PrintSymbolFromFile(Inp: TEXT);
VAR 
	Holder: INTEGER;
	Symbol: SymbolSetType;
BEGIN {PrintSymbolFromFile}
	WHILE NOT EOF
	DO 
		BEGIN	
			Symbol := [];
			WHILE NOT EOLN(Inp)
			DO
				BEGIN
					ReadNumber(Inp, Holder);
					IF (Holder > 0) AND (Holder < MaxSymbols + 1)
					THEN 
						Symbol := Symbol + [Holder];
				END;
			PrintBySet(Symbol);
			READLN(Inp);
			WRITELN
		END	
END; {PrintSymbolFromFile}

BEGIN {SymbolsDrawer}
END. {SymbolsDrawer}
