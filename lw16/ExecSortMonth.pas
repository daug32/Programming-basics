PROGRAM ExecSortMonth(INPUT, OUTPUT);
USES DateIO;
VAR Holder: TEXT;

PROCEDURE SortMonth(VAR FIn, FOut: TEXT);
VAR
	IsEmpty: BOOLEAN;
	Mo1, Mo2: Month;
	Ch: CHAR;
BEGIN {SortMonth}	
	IsEmpty := TRUE;
	IF NOT EOLN(FIn) THEN READ(FIn, Ch);
	IF NOT EOLN(FIn) THEN READ(FIn, Ch);
	IF NOT EOLN(FIn) THEN READ(FIn, Ch);
	IF NOT EOLN(FIn) THEN READ(FIn, Ch);
	IF NOT EOLN(FIn) THEN READ(FIn, Ch);
	IF NOT EOLN(FIn) THEN IsEmpty := FALSE;
	RESET(FIn);

	IF IsEmpty THEN WRITE('¬ файле не записаны мес€ца')	
	ELSE 
		BEGIN
			ReadMonth(FIn, Mo1);
			ReadMonth(FIn, Mo2);
			IF  ((Mo1 = NoMonth) AND (Mo2 = NoMonth)) 
			THEN 
				WRITE(FOut, '¬ходные данные введены неверно')
			ELSE IF (Mo1 = Mo2)
			THEN 
				BEGIN
					WRITE(FOut, 'ќба мес€ца ');
					WriteMonth(FOut, Mo1)
				END
			ELSE 
				BEGIN
					WriteMonth(FOut, Mo1);
					IF Mo1 < Mo2 
					THEN 
						WRITE(FOut, ' предшествует ') 
					ELSE 
						WRITE(FOut, ' следует за ');
					WriteMonth(FOut, Mo2)
				END
		END;
	WRITELN(FOut)
END; {SortMonth}          

BEGIN {ExecSortMonth}      
	WRITELN('Input: 1'); 
	WRITE('Output: ');    
	REWRITE(Holder);
	WRITELN(Holder, '1');
	RESET(Holder);
	SortMonth(Holder, OUTPUT);

	WRITELN('Input: APRJUL'); 
	WRITE('Output: ');
	REWRITE(Holder);
	WRITELN(Holder, 'APRJUL'); 
	RESET(Holder);             
	SortMonth(Holder, OUTPUT);
                    
	WRITELN('Input: AprJul');
	WRITE('Output: ');
	REWRITE(Holder);
	WRITELN(Holder, 'AprJul');
	RESET(Holder);
	SortMonth(Holder, OUTPUT);
                           
	WRITELN('Input: JULAPR');    
	WRITE('Output: ');
	REWRITE(Holder);
	WRITELN(Holder, 'JULAPR');  
	RESET(Holder);
	SortMonth(Holder, OUTPUT);
                           
	WRITELN('Input: DECDEC');  
	WRITE('Output: ');
	REWRITE(Holder);
	WRITELN(Holder, 'DECDEC');
	RESET(Holder);
	SortMonth(Holder, OUTPUT);
END. {SortMonth}
