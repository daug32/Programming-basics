PROGRAM HelloWeb(INPUT, OUTPUT);  
USES 
	DOS;
BEGIN
	WRITELN('Content-Type: text/plain');
	WRITELN;
	WRITELN('Start');
	WRITELN(GetEnd('REQUEST_METHOD'));
	WRITELN('End');
END.
