:- include('utils.pl'). 
 
% -----------------------------------------------
%	Input of actual cell 
% ----------------------------------------------- 

/**
 * @brief: Get the line and column as input.  
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
%	Input movement direction [asdw]
% -----------------------------------------------  

getMoveInput(Letter):-
	print('MOVE[asdw]>>'),
	get_char(Letter),
	skip_line. 

