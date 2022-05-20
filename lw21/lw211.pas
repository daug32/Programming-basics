PROGRAM Encryption(INPUT, OUTPUT);   
{Переведит символы из INPUT в код согласно Chiper 
 и печатает новые символы в OUTPUT}
CONST                               
  Len = 20;                         
TYPE                                
  Str = ARRAY [1 .. Len] OF CHAR;
  Chiper = ARRAY [' ' .. 'Z'] OF CHAR;  
VAR                                     
  Msg: Str;                                   
  Code: Chiper;                      
	I: INTEGER;   	
	SymbolsCount: 1 .. Len;
																 
PROCEDURE Initialize(VAR Code: Chiper); 
{Присвоить Code шифр замены}            
BEGIN {Initialize}                      
  Code['A'] := 'Z';                     
  Code['B'] := 'Y';                     
  Code['C'] := 'X';                     
  Code['D'] := '#';                     
  Code['E'] := 'V';                     
  Code['F'] := 'U';                     
  Code['G'] := 'T';                     
  Code['H'] := 'S';                     
  Code['I'] := 'I';                     
  Code['J'] := 'Q';                     
  Code['K'] := 'P';                     
  Code['L'] := '!';                     
  Code['M'] := 'N';                                                             
  Code['N'] := 'M';                     
  Code['O'] := '2';                     
  Code['P'] := 'K';                     
  Code['Q'] := '$';                     
  Code['R'] := 'D';                     
  Code['S'] := 'H';                     
  Code['T'] := '*';                     
  Code['U'] := 'F';                     
  Code['V'] := 'E';                     
  Code['W'] := 'T';                     
  Code['X'] := 'C';                     
  Code['Y'] := 'B';                     
  Code['Z'] := 'A';
	Code[' '] := '1'                  
END;  {Initialize}
                    
PROCEDURE Encode(VAR S: Str; SymbolsCount: INTEGER);                           
		{Вывоит символы из Code, оответствующие символам из S}
VAR                                      
	Symbol: CHAR;                                    
  Index: 1 .. Len;
	MinSymbols: INTEGER;                                                                   
BEGIN {Encode}  
	{Узнать, сколько фактических символов в строке}        
	IF SymbolsCount < Len 
	THEN MinSymbols := SymbolsCount
	ELSE MinSymbols := Len;  

	{Обработфть каждый элемент входной строки}
	FOR Index := 1 TO MinSymbols
  DO          
		BEGIN                                          
			Symbol := S[Index];
	    IF Symbol IN [' ', 'A' .. 'Z']
  	  THEN
    	  WRITE(Code[Symbol])                             
	    ELSE                                                
	      WRITE(Symbol);
		END;
  WRITELN                                               
END;  {Encode}
                
BEGIN {Encryption}                            
  {Инициализировать Code}                     
  Initialize(Code); 

	{Обработать входные данные}                          
  WHILE NOT EOF                               
  DO                                          
    BEGIN                                    
      {Читать строку в Msg и распечатать ее}  
      I := 0;                                 
      WHILE NOT EOLN AND (I < Len)            
      DO                                      
        BEGIN                                 
          I := I + 1;                         
          READ(Msg[I]);                       
          WRITE(Msg[I])                       
        END;                                 
      READLN;                                 
      WRITELN;
			SymbolsCount := I;              
                          
      {Распечатать копированное сообщение}   
      Encode(Msg, SymbolsCount)                             
    END                                       
END.  {Encryption}


