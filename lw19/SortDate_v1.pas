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
  RESET(DateFile);

	{
  WHILE NOT EOF(FInput)
  DO
		{Поместить новую дату в DateFile в соответствующее место}

	{Копируем DateFile в OUTPUT}
	RESET(DateFile);
	CopyOut(DateFile);

END.{SortDate}

