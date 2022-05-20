PROGRAM InsertSort(INPUT, OUTPUT);
CONST 
	Max = 16;
	ListEnd = 0;
TYPE
	RecArray = ARRAY [1 .. Max] OF 
							RECORD 
								Key: CHAR;
								Next: 0 .. Max;
							END;
VAR                          
	Extra: CHAR;
	Arr: RecArray;
	Index: INTEGER; 
	First, Prev, Curr: 0 .. Max;

PROCEDURE PrintList;
VAR I: INTEGER;
BEGIN {PrintList}
	FOR I := 1 TO Max DO WRITE(Arr[I].Key, ',');
	WRITELN
END; {PrintList}

PROCEDURE InsertElement(Element: CHAR; Pos: INTEGER);
VAR 
	Found: BOOLEAN;
BEGIN {AddElement}
	Prev := 0;
	Curr := 0;
	Next := 0;

	WHILE (Arr[Curr] > Elemenet) AND 
				(Arr[Curr] = )
	DO 
		BEGIN
			
		END;
                     
	Arr[Pos].Next = Curr;
	IF Prev = 0 
	THEN 
		First := Pos;
	ELSE 
		Arr[Prev].Next = Pos;
END; {AddElement}

BEGIN 
	Index := 0;
	First := 0;

	WHILE NOT EOLN 
	DO 
		BEGIN 
			Index := Index + 1;
		
			IF Index > Max
			THEN 
				BEGIN 
					READ(Extra);
					WRITELN(Extra, ' is not part of a deal');
					CONTINUE;
				END;
			
			READ(Extra);
			InsertElement(Extra);
		END;		

	PrintList;
END.
