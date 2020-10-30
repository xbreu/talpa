



/** 
 * @brief: Convert input line to list position 
 */
getRealLine(GameState, Line, RealLine):-  
	boardNumLines(GameState, NumLines), 
	RealLine is NumLines - Line. 

/**
 * @brief: Convert input column to list position 
 */ 
getRealCol(Col, RealCol):-
	char_code(Col, X),    
	RealCol is X-97. 



getInputMove(Player, Line, Col):-       
	printPlayerTurn(Player), 
	write('LINE >> '), 
	get_code(Line1),      
	get_char(_),
	write('COL >> '),  
	get_char(Col),
	Line is Line1 - 48. 

printPlayerTurn(Player):-  
	nl, nl,
	write('--Player '), 
	write(Player),
	write(' turn--'), 
	nl, nl.






