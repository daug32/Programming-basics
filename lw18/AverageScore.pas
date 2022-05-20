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

PROCEDURE ReadLastName;
VAR Ch: CHAR;
BEGIN {ReadLastName}
	WHILE NOT EOLN
	DO 
		BEGIN
			READ(Ch);
			WRITE(Ch)
		END
END; {ReadLastName}

BEGIN {AverageScore}
  ClassTotal := 0;
  Student := 1;   
  WRITELN('Student averages:');

  WHILE Student <= ClassSize
  DO 
    BEGIN
      TotalScore := 0;
      WhichScore := 1;         

			WRITE('Student''s name: ');   	
			ReadLastName;
			WRITE(': ');
		
			{Get student's marks}
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

			{Round and print student's name}
			WRITE('Avarage score: ');
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

