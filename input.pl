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

getCellCol(RealCol):- 
	numberOfCols(MaxCols),  
	print('COL>> '), 
	get_char(Col),     
	skip_line, 
	getRealCol(Col, RealCol), 
	RealCol >= 0, 
	RealCol < MaxCols, !. 
	
getCellCol(RealCol):-
	numberOfCols(MaxCols), 
	format('>Invalid input. Range must be [0-~d).<', MaxCols), 
	nl, 
	getCellCol(RealCol). 

printPlayerTurn(Player):-   
	nl,
	format('--Player ~d turn--', Player),  
	nl. 


% -----------------------------------------------
% Input movement direction [asdw]
% -----------------------------------------------  

getMoveInput(Letter):-
	getInputOpt('MOVE[asdw]>>', ['a','s','d','w'], Letter).



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

% -----------------------------------------------
% Get Any input int	
% -----------------------------------------------

getInputInt(Text, Floor, Ceil, Value):-
	format('~s\n', Text), 
	get_char(ValueChar), 
	skip_line,
	
	char_code(ValueChar, ValueASCII),
	Value is ValueASCII - 48, 
	
	Value >= Floor, 
	Value =< Ceil, !.  

getInputInt(Text, Floor, Ceil, Value):-  
	write('Invalid input !!'), nl,
	getInputInt(Text, Floor, Ceil, Value). 

% -----------------------------------------------
% Get Any input from selected options	
% -----------------------------------------------

getInputOpt(Text, Options , Value):-
	format('~s\n', Text), 
	get_char(Value), 
	skip_line,
	
	member(Value, Options), !.  

getInputOpt(Text, Options , Value):- 
	write('Invalid input !!'), nl,
	getInputOpt(Text, Options, Value).
