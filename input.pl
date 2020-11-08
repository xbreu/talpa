:- consult('utils.pl'). 
:- consult('singleton.pl').

% -----------------------------------------------
% Input of actual cell 
% ----------------------------------------------- 

/**
 Get the line and column as input of determine player.  

 getCellInput(+Player, -Line, -Col). 
 +Player 	: Number of the player.
 -Line		: Line read from input. 
 -Col		: Column read from input.   
 */ 
getCellInput(Player, Line, Col):-       
	printPlayerTurn(Player),  
	getCellLine(Line), 
	getCellCol(Col).
	
getCellLine(Line):- 
	print('LINE>> '),  
	get_char(Line1),       
	skip_line,
	char_code(Line1, CodeLine), 
	Line is CodeLine - 48.    

getCellCol(Col):- 
	print('COL>> '), 
	get_char(Col),     
	skip_line. 

printPlayerTurn(Player):-   
	nl,
	format('--Player ~d turn--', Player),  
	nl. 


% -----------------------------------------------
% Input movement direction [asdw]
% -----------------------------------------------  

getMoveInput(Letter):-
	print('MOVE[asdw]>>'),
	get_char(Letter),
	skip_line. 


% -----------------------------------------------
% Get Real Input 	
% -----------------------------------------------

getRealInput(Line, Col, RealLine, RealCol):-
	getRealLine(Line, RealLine), 
	getRealCol(Col, RealCol).

/** 
 Converts input line to list position.
 
 getRealLine(+Line, -RealLine). 
 +Line		: The Line from input. 
 -RealLine	: The line of the +Line in matrix. 
*/
getRealLine(Line, RealLine):-  
	numberOfLines(NumLines), 
	RealLine is NumLines - Line. 

/**
 Converts input column to list position.
 
 getRealCol(+Col, -RealCol).
 +Col 		:The Col from input. 
 -RealCol	: The column of the +Col in matrix.     
 */ 
getRealCol(Col, RealCol):-
	char_code(Col, X),    
	RealCol is X-97. 
