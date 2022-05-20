PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 3	;
  ClassSize = 5;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
	LastNameHolder: TEXT;

PROCEDURE SaveLastName(VAR Holder: TEXT);
VAR Ch: CHAR;
BEGIN {SaveLastName}
	WHILE NOT EOLN
	DO 
		BEGIN
			READ(Ch);
			WRITE(Holder, Ch)			
		END;
	WRITELN(Holder)
END; {SaveLastName}

PROCEDURE PrintSavedLastName(VAR Holder: TEXT);
VAR Ch: CHAR;
BEGIN {PrintSavedLastName}
	WHILE NOT EOLN(Holder)
	DO	
		BEGIN
			READ(Holder, Ch);	
			WRITE(Ch)
		END
END; {PrintSavedLastName}

BEGIN {AverageScore}
  ClassTotal := 0;
  Student := 1;   
 
  WHILE Student <= ClassSize
  DO 
    BEGIN
      TotalScore := 0;
      WhichScore := 1; 
    	
			{Get student's last name}
			WRITELN('Enter student''s name:');
			REWRITE(LastNameHolder);
			SaveLastName(LastNameHolder);
		
			{Get student's marks}
		  WRITELN('Enter student''s averages:');
      WHILE WhichScore <= NumberOfScores
      DO
        BEGIN
          READ(NextScore);      					                  
					WhichScore := WhichScore + 1;
          TotalScore := TotalScore + NextScore
        END; 
      READLN; 	
       
			{Calculate student's average score}
      TotalScore := TotalScore * 10;
      Ave := TotalScore DIV NumberOfScores;

			{Print student's name}             
			RESET(LastNameHolder);
			WRITE('Student ''');    
			PrintSavedLastName(LastNameHolder);
			WRITE(''': ');

			{Round average student's score}
      IF Ave MOD 10 >= 5
      THEN
        WRITE(Ave DIV 10 + 1)
      ELSE 
		  	WRITE(Ave DIV 10);
			WRITELN(';');
			WRITELN;

			{Save student's score in general score}
      ClassTotal := ClassTotal + TotalScore;
			Student := Student + 1
    END;  

	{Print result}
  WRITELN;            
  WRITELN('Class average:');
  ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
END.  {AverageScore}

