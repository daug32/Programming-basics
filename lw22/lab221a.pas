PROGRAM InsertionSort(INPUT, OUTPUT);      
{Сортируем символы из INPUT}
CONST                                         
  Max = 16;                                   
  ListEnd = 0;                                
TYPE                                          
  RecArray = ARRAY [1 .. Max] OF              
               RECORD                         
                 Key: CHAR;                   
                 Next: 0 .. Max              
               END;                           
VAR                                           
  Arr: RecArray;                              
  First, Index: 0 .. Max;                     
  Prev, Curr: 0 .. Max;                       
  Extra: CHAR;                                
  Found: BOOLEAN;                             
BEGIN {InsertionSort}                         
  First := 0;                                 
  Index := 0; 
                                
  WHILE NOT EOLN                              
  DO                                          
    BEGIN {WHILE}                                       
      {Помещать запись в список, если позволяет пространство, 
			 иначе игнорировать и сообщать об ошибке}                         
      Index := Index + 1;                                                                                  
      IF Index > Max                                                                                       
      THEN                                                                                                 
        BEGIN                                                                                              
          READ(Extra);                                                                                     
          WRITELN('Сообщение содержит: ', Extra, '. Игнорируем.');              
        END                                                                                                
      ELSE                                                                                                 
        BEGIN                                                                                              
          READ(Arr[Index].Key);                                                                            
          {Включаем Arr[Index] в связанный список}                               
        END                                                                                               
    END; {WHILE}                                
             
END.  {InsertionSort}                                                                                      
