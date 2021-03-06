UNIT StringHandler;
INTERFACE 
                                      
FUNCTION IsLetter(Ch: CHAR) : BOOLEAN;
FUNCTION ToLower(Str: STRING) : STRING;
FUNCTION StringComparer(VAR A, B: STRING) : INTEGER;
FUNCTION ReadWord(VAR Inp: TEXT) : STRING;
                                       
IMPLEMENTATION          

FUNCTION IsLetter(Ch: CHAR) : BOOLEAN;
BEGIN {IsLetter}
  IsLetter := 
    ((Ch >= '?') AND (Ch <= '?')) OR
    ((Ch >= 'a') AND (Ch <= 'z')) OR
    ((Ch >= '?') AND (Ch <= '?')) OR 
    ((Ch >= 'A') AND (Ch <= 'Z'))
END; {IsLetter}   

FUNCTION ToLower(Str: STRING) : STRING;
VAR 
  I, Len, Holder, LetterDiff: INTEGER;
BEGIN 
  Len := LENGTH(Str);  
  LetterDiff := ORD('A') - ORD('a');

  FOR I := 1 TO Len
  DO 
    BEGIN
      IF ((Str[I] >= '?') AND (Str[I] <= '?')) OR 
         ((Str[I] >= 'A') AND (Str[I] <= 'Z'))
      THEN
        BEGIN
          Holder := ORD(Str[I]) - LetterDiff;
          Str[I] := CHR(Holder)
        END
    END;  
  
  ToLower := Str
END;

FUNCTION StringComparer(VAR A, B: STRING) : INTEGER;
{Returns:
-1 if A is less than B,
0 if A is equal to B, 
1 if A is greater than B}
VAR 
  LengthA, LengthB: INTEGER;
  Index, MaxLength: INTEGER;
BEGIN {Comparer}
  LengthA := LENGTH(A);
  LengthB := LENGTH(B); 

  IF LengthA > LengthB
  THEN
    MaxLength := LengthA
  ELSE
    MaxLength := LengthB;
  
  FOR Index := 1 TO MaxLength
  DO
    BEGIN
      IF Index > LengthA
      THEN 
        BEGIN
          StringComparer := -1;
          EXIT
        END; 

      IF Index > LengthB
      THEN 
        BEGIN
          StringComparer := 1;
          EXIT
        END;
 
      IF A[Index] > B[Index]
      THEN
        BEGIN
          StringComparer := 1;
          EXIT
        END;
     
      IF A[Index] < B[Index]
      THEN
        BEGIN
          StringComparer := -1;
          EXIT
        END     
    END;
  
  StringComparer := 0  
END; {Comparer} 

FUNCTION ReadWord(VAR Inp: TEXT) : STRING;
VAR
  Ch, PrevCh: CHAR;
  Word: STRING;  
  IsWord: BOOLEAN;
BEGIN {ReadWord}  
  Ch := ' ';      
  PrevCh := ' ';    
  Word := '';
  ReadWord := '';
  IsWord := TRUE;

  WHILE NOT IsLetter(Ch)
  DO
    BEGIN 
      IF EOF(Inp) THEN EXIT;
      READ(Inp, Ch)
    END;

  WHILE IsWord
  DO 
    BEGIN                   
      PrevCh := Ch;

      IF EOF(Inp) 
      THEN 
        BEGIN
          ReadWord := Word + Ch;
          EXIT
        END;
      READ(Inp, Ch);
         
      IsWord := IsLetter(Ch);
      {This willn't save words like this 
      'some-' with '-' at the end}
      IF IsWord OR (PrevCh <> '-')
      THEN          
        Word := Word + PrevCh;

      IsWord := IsWord OR (Ch = '-')
    END;
  
  ReadWord := Word
END; {ReadWord}

BEGIN {StringHandler}
END. {StringHandler}
