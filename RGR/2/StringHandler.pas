UNIT StringHandler;
INTERFACE 
                                       
FUNCTION IsUpper(Ch: CHAR) : BOOLEAN;
FUNCTION ToLower(Str: STRING) : STRING;
FUNCTION IsWordChar(Ch: CHAR) : BOOLEAN;             
FUNCTION ReadWord(VAR Inp: TEXT) : STRING;
FUNCTION StringComparer(VAR A, B: STRING) : INTEGER; 
                                       
IMPLEMENTATION  

FUNCTION IsUpper(Ch: CHAR) : BOOLEAN;
BEGIN
  IsUpper := 
    ((Ch >= '�') AND (Ch <= '�')) OR 
    ((Ch >= 'A') AND (Ch <= 'Z'));
END;

FUNCTION ToLower(Str: STRING) : STRING;
VAR 
  I, Len, Holder, LetterDiff: INTEGER;
BEGIN 
  Len := LENGTH(Str);  
  LetterDiff := ORD('A') - ORD('a');

  FOR I := 1 TO Len
  DO 
    BEGIN
      IF NOT IsUpper(Str[I])
      THEN
        CONTINUE;
      Holder := ORD(Str[I]) - LetterDiff;
      Str[I] := CHR(Holder);
    END;  
  
  ToLower := Str;
END;

FUNCTION IsWordChar(Ch: CHAR) : BOOLEAN;
BEGIN {WordChar}
  IsWordChar := 
    ((Ch >= '�') AND (Ch <= '�')) OR
    ((Ch >= 'a') AND (Ch <= 'z')) OR
    ((Ch >= '�') AND (Ch <= '�')) OR 
    ((Ch >= 'A') AND (Ch <= 'Z'));
END; {WordChar}   

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
  
  StringComparer := 0;  
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
  IsWord := TRUE;

  WHILE (NOT IsWordChar(Ch)) AND (NOT EOF(Inp))
  DO 
    READ(Inp, Ch);

  WHILE IsWord AND (NOT EOF(Inp)) 
  DO 
    BEGIN                   
      PrevCh := Ch;
      READ(Inp, Ch);
      IsWord := IsWordChar(Ch);

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
