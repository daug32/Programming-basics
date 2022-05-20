PROGRAM Lecture(INPUT, OUTPUT);
CONST 
	NameLength = 15;
	AddressLength = 20;
	Max = 100;
TYPE
	Month = (Jan, Feb, Mar, Apr, May, Jun, Jul, Sep, Oct, Nov, Dec);
	Sex = (Male, Female, Trap);
	Date = 	RECORD 
						Day  : 1 .. 31;
						Mo   : Month;
				  	Year : INTEGER;
					END;
	Person =	RECORD
							Name   : STRING[NameLength];
							Birth  : Date;
							Gender : Sex;
							Addr   : STRING[AddressLength];
							Next   : [0 .. Max]
						END;
VAR 
	PRegs : ARRAY[1 .. Max] OF Person;
BEGIN
	Inedx : First;
	WHILE Index <> 0
	DO 
		BEGIN 
			{Printing PRegs[Index]}

			Index := Prex[Index].Next;
		END
END.
