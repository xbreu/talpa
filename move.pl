:- include('utils.pl'). 



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

 
% -----------------------------------------------
%	Input 	
% -----------------------------------------------

/**
 * @brief: Get the line and Col from the user
 */ 
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

% -----------------------------------------------
%	Input validation 
% -----------------------------------------------


validateLine(GameState, Line, Valid):-  
	boardNumLines(GameState, NumLines),
	(Line =< 0; Line > NumLines), !, 
   	Valid is 0. 

validateLine(GameState, Line, Valid):-  
	Valid is 1. 


validateCol(GameState, Col, Valid):-  
	boardNumCols(GameState, NumCols),
	(Col =< 0; Col > NumCols), !, 
   	Valid is 0. 

validateCol(GameState, Col, Valid):-  
	Valid is 1. 




