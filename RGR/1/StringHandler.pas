UNIT StringHandler;
INTERFACE 
                                      
FUNCTION IsWordChar(Ch: CHAR) : BOOLEAN;
FUNCTION ToLower(Str: STRING) : STRING;
FUNCTION StringComparer(VAR A, B: STRING) : INTEGER;
     
FUNCTION ReadWord(
  VAR Inp: TEXT; 
  VAR ReadedSymbols: INTEGER;
  MaxSymbols: INTEGER) : STRING;
                                       
IMPLEMENTATION          

FUNCTION IsWordChar(Ch: CHAR) : BOOLEAN;
BEGIN {WordChar}
  IsWordChar := 
    ((Ch >= 'à') AND (Ch <= 'ÿ')) OR
    ((Ch >= 'a') AND (Ch <= 'z')) OR
    ((Ch >= 'À') AND (Ch <= 'ß')) OR 
    ((Ch >= 'A') AND (Ch <= 'Z'));
END; {WordChar}   

FUNCTION ToLower(Str: STRING) : STRING;
VAR 
  I, Len, Holder, LetterDiff: INTEGER;
BEGIN 
  Len := LENGTH(Str);  
  LetterDiff := ORD('A') - ORD('a');

  FOR I := 1 TO Len
  DO 
    BEGIN
      IF ((Str[I] >= 'À') AND (Str[I] <= 'ß')) OR 
         ((Str[I] >= 'A') AND (Str[I] <= 'Z'))
      THEN
        BEGIN
          Holder := ORD(Str[I]) - LetterDiff;
          Str[I] := CHR(Holder)
        END
    END;  
  
  ToLower := Str;
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
  
  StringComparer := 0;  
END; {Comparer} 

FUNCTION ReadWord(
  VAR Inp: TEXT; 
  VAR ReadedSymbols: INTEGER;
  MaxSymbols: INTEGER) : STRING;
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
    BEGIN 
      READ(Inp, Ch);
      ReadedSymbols := ReadedSymbols + 1;
      {Limiting the count of reading symbols}
      IF (MaxSymbols > 0) AND
         (ReadedSymbols > MaxSymbols)
      THEN  
        EXIT;
    END;

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
                              
      {Limiting the count of reading symbols} 
      ReadedSymbols := ReadedSymbols + 1;
      IF (MaxSymbols > 0) AND
         (ReadedSymbols > MaxSymbols)
      THEN  
        BEGIN  
          ReadWord := Word;
          EXIT
        END;

      IsWord := IsWord OR (Ch = '-')
    END;

  IF IsWordChar(Ch) AND EOF(Inp) 
  THEN 
    Word := Word + Ch;
  
  ReadWord := Word
END; {ReadWord}

BEGIN {StringHandler}
END. {StringHandler}
