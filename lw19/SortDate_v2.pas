PROGRAM SortDate(INPUT, OUTPUT);  
USES 
	DateManager;
VAR
  Copying: BOOLEAN;
  D, VarDate: Date;
  TFile, DateFile: FileOfDate;
  FInput: TEXT;
 
BEGIN{SortDate}     
	{Initialization}                            
  ASSIGN(FInput, 'FI.TXT'); {Init input file}
  ASSIGN(TFile, 'TF.DAT'); {Init temporary file}
  ASSIGN(DateFile, 'DF.DAT'); {Init output file}

  REWRITE(DateFile);
  RESET(FInput);
  ReadDate(FInput, VarDate);
  READLN(FInput);
  WRITE(DateFile, VarDate);
  // RESET(DateFile);

  WHILE NOT EOF(FInput)
  DO
		BEGIN
			{��������� ����� ���� � DateFile � ��������������� �����}
	    ReadDate(FInput, D);
	    READLN(FInput);
	    IF (D.Mo <> NoMonth)
	    THEN
	      BEGIN
	        {�������� D � TFile}
	        WRITE(DateFile, D);		
	      END;
		END;
 		
	{�������� DateFile � OUTPUT}
	RESET(DateFile);
	CopyOut(DateFile);

END.{SortDate}

