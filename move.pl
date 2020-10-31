:- include('utils.pl'). 



getRealInput(GameState, Line, Col, RealLine, RealCol):-
	getRealLine(GameState, Line, RealLine), 
	getRealCol(Col, RealCol).

/** 
 * @brief: Convert input line to list position 
 */
getRealLine(GameState, Line, RealLine):-  
	getBoardNumLines(GameState, NumLines), 
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

getValidInput(GameState, Player, Line, Col):-
	getMoveInput(Player, InputLine, InputCol),  
	getRealInput(GameState, InputLine, InputCol, RealLine, RealCol),    
	auxGetValidInput(GameState, Player, Line, Col, RealLine, RealCol). 


auxGetValidInput(GameState, Player, Line, Col, RealLine, RealCol):-
	\+validatePos(GameState, RealLine, RealCol), !,  
	nl, 
	print('MOVE NOT VALID'),
	nl,
	getValidInput(GameState, Player, Line, Col).   

auxGetValidInput(GameState, Player, Line, Col, Line, Col):-  
	validatePos(GameState, Line, Col).
 

/**
 * @brief: Get the line and column as input.  
 */ 
getMoveInput(Player, Line, Col):-       
	printPlayerTurn(Player),  
	getMoveLine(Line), 
	getMoveCol(Col).
	
getMoveLine(Line):- 
	print('LINE>> '),  
	get_char(Line1),      
	get_char(_), 				% get's the \n character   
	char_code(Line1, CodeLine), 
	Line is CodeLine - 48.    

getMoveCol(Col):- 
	print('COL>> '), 
	get_char(Col),    
	get_char(_). 				% get's the \n character   


printPlayerTurn(Player):-   
	nl,
	format('--Player ~d turn--', Player),  
	nl.

% -----------------------------------------------
%	Input validation 
% -----------------------------------------------

validatePos(GameState, Line, Col):-
	validateLine(GameState, Line),
	validateCol(GameState, Col).   

validateLine(GameState, Line):-  
	getBoardNumLines(GameState, NumLines),
	Line >= 0, Line < NumLines. 


validateCol(GameState, Col):-  
	getBoardNumCols(GameState, NumCols), 
	Col >= 0, Col < NumCols.





