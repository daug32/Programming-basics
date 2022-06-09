UNIT FileHandler;
INTERFACE
	
PROCEDURE CopyFile(VAR FromFile, ToFile: TEXT);

IMPLEMENTATION

PROCEDURE CopyFile(VAR FromFile, ToFile: TEXT);
VAR 
	Str: STRING;
BEGIN {CopyFile}
  WHILE NOT EOF(FromFile)
  DO 
    BEGIN
      READLN(FromFile, Str);
      WRITELN(ToFile, Str)
    END
END; {CopyFile}

BEGIN {FileHandler}
END. {FileHandler}
