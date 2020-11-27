:- consult('../utils.pl').
:- consult('../variables.pl').

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

/**
 Gets the line as input of determine player with error treatment. 
 It will returns if the player gives a valid input. 

 getCellLine(-Line).   
 */ 	
getCellLine(RealLine):- 
	numberOfLines(MaxLines),
	RealMaxLines is MaxLines + 1,
	getInputInt('LINE >>  ', 1, RealMaxLines, Line),
	getRealLine(Line, RealLine).  

/**
 Gets the column as input of determine player with error treatment. 
 It will returns if the player gives a valid input. 

 getCellCol(-RealCol).   
 */
getCellCol(RealCol):- 
	numberOfCols(MaxCols),  
	print('COL >> '), 
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
/** 
 Get a valid input between a range. 
 
 getInputInt(+Line, -RealLine). 
 +Label		: The Label for the input. 
 +Floor		: Min value that can be chosen. 
 +Ceil 		: Max value (not including it self) that can be chosen. 
 -Value 	: Valid value input. 
*/
getInputInt(Label, Floor, Ceil, Value):-
	format('~s\n', Label),
	get_char(ValueChar), 
	skip_line,
	
	char_code(ValueChar, ValueASCII),
	Value is ValueASCII - 48, 
	
	Value >= Floor,
	Value < Ceil, !.

getInputInt(Label, Floor, Ceil, Value):-  
	write('Invalid input !!'), nl,
	getInputInt(Label, Floor, Ceil, Value). 

% -----------------------------------------------
% Get Any input from selected options	
% -----------------------------------------------

/** 
 Get a valid input, where the input be one of the given options. 
 
 getInputOpt(+Label, +Options, -Value). 
 +Label		: Label for the input. 
 +Options	: Options of which the input must belong.
 -Value		: The valid input.  
*/
getInputOpt(Label, Options , Value):-
	format('~s\n', Label), 
	get_char(Value), 
	skip_line,
	
	member(Value, Options), !.  

getInputOpt(Label, Options , Value):- 
	write('Invalid input !!'), nl,
	getInputOpt(Label, Options, Value).

printPlayerTurn(Player):-   
	nl,
	code(Player, Code),
	format('--Player ~s turn--', Code),
	nl.

% In case we want to remove a piece. 
getMovement_r(GameState, Player, Row, Column):-
	write('No captures available. Remove a piece'), nl, 
	getCellLine(Row),
	getCellCol(Column),
	getValueInMatrix(GameState, Row, Column, Player), !. 

getMovement_r(GameState, Player, Row, Column) :-
	print('That piece is not yours!\n'),
	getMovement_r(GameState, Player, Row, Column).

getMovement(GameState, Player, Row, Column, Direction) :-
	getCellLine(Row),
	getCellCol(Column),
	getValueInMatrix(GameState, Row, Column, Player), !,
	getMoveInput(Direction).

getMovement(GameState, Player, Row, Column, Direction) :-
	print('That piece is not yours!\n'),
	getMovement(GameState, Player, Row, Column, Direction).




