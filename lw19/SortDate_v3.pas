PROGRAM SortDate(INPUT, OUTPUT); 
USES 
	DateManager;
VAR                
  FInput: TEXT;    
  Copying: BOOLEAN;
  D, VarDate: Date;
  TFile, DateFile: FileOfDate;
 
BEGIN{SortDate}  
	{Initialization}                           
  ASSIGN(TFile, 'TF.DAT'); {Init temporary file}    
  ASSIGN(FInput, 'FI.TXT'); {Init input file}
  ASSIGN(DateFile, 'DF.DAT'); {Init output file}
	
	REWRITE(DateFile);
  RESET(FInput);
  ReadDate(FInput, VarDate);
  READLN(FInput);
  WRITE(DateFile, VarDate);
  RESET(DateFile);

  WHILE NOT EOF(FInput)
  DO
		BEGIN   
    	ReadDate(FInput, D);
    	READLN(FInput);
    	IF (D.Mo <> NoMonth)
    	THEN
      	BEGIN   
					{Copy elements that are less than D}
      		REWRITE(TFile);
      		Copying := TRUE;
      		WHILE NOT EOF(DateFile) AND Copying
      		DO
        		BEGIN
          		READ(DateFile, VarDate);
          		IF Less(VarDate, D)
          		THEN
            		WRITE(TFile, VarDate)
          		ELSE
            		Copying := FALSE;
        		END;

					{Copy D into TFile}
        	WRITE(TFile, D);   

					{Copy other elements from DateFile to TFile}
					WRITE(TFile, VarDate);
					WHILE NOT EOF(DateFile)
					DO 
						BEGIN
							READ(DateFile, VarDate);  
							WRITE(TFile, VarDate)
						END;

					{Save processed data of temporary file TFile into DateFile}
					RESET(TFile);
					REWRITE(DateFile);
					WHILE NOT EOF(TFile)
					DO 
						BEGIN				
							READ(TFile, VarDate);
							WRITE(DateFile, VarDate)
						END;
					RESET(DateFile)
      END
		END;
 		
	{Copy DateFile into OUTPUT}  
	RESET(DateFile);
	CopyOut(DateFile)
END.{SortDate}

