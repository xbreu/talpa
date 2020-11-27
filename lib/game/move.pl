:- use_module(library(lists)).
:- consult('../utils.pl').
:- consult('../variables.pl').

% ----------------------------------------------- 
%  Main function for make a move 	
% ----------------------------------------------- 

% Make a movement if valid. If letter is 'r' we need to remove an piece.
% move(+GameState, +Move, +NewGameState)
% +Gamestate 	: Actual GameState.
% +RealLine 	: Line represented from 0 to number of lines in the board.
% +RealCol 	:  Column represented from 0 to the number of columns in the board.
% +Letter 	: One of a,s,d,w. Representing the direction of the movement.
% -NewGameState : Return value of the new game state.

% Remove a peace case there isn't any moves to do.
move(GameState, [RealLine-RealCol, 'r'], NewGameState):- !,
	validPos(RealLine, RealCol),
	replaceInMatrix(GameState, RealLine-RealCol, 0, NewGameState).

move(GameState, [RealLine-RealCol, Letter], NewGameState):- !,
	validPos(RealLine, RealCol),
	capture(GameState, Letter, RealLine, RealCol, CaptureLine, CaptureCol),   
	% Does the capture.
	getValueInMatrix(GameState, RealLine, RealCol, CellCurrValue), 
	replaceInMatrix(GameState, RealLine-RealCol, 0, CurrGameState), 
	replaceInMatrix(CurrGameState, CaptureLine-CaptureCol, CellCurrValue, NewGameState). 


% -----------------------------------------------
% Functions get line and col of captured cell 
% ----------------------------------------------- 

% Gets the line and col of the cell to be captured. Assumes that +Line and +Col are valid.
% validCapture(+GameState, +Direction, +Line, +Col, +NewLine, +NewCol)
% + GameState 	: The actual game board.
% + Direction 	: The direction of the movement.
% + Line		: The actual line of the player.
% + Col 		: The atual col of the player.
% + NewLine	: The new line of the player.
% + NewCol	: The new column of the player.
capture(GameState, 'w', Line, Col, NewLine, Col):-  !,  
	NewLine is Line -1, 
	validLine(NewLine),
	distinctPlayer(GameState, Line, Col, NewLine, Col).

capture(GameState, 's', Line, Col, NewLine, Col):-  !,  
	NewLine is Line +1, 
	validLine(NewLine),
	distinctPlayer(GameState, Line, Col, NewLine, Col). 

capture(GameState, 'd', Line, Col, Line, NewCol):- !, 
	NewCol is Col +1, 
	validCol(NewCol),
	distinctPlayer(GameState, Line, Col, Line, NewCol).  

capture(GameState, 'a', Line, Col, Line, NewCol):- !, 
	NewCol is Col -1, 
	validCol(NewCol),
	distinctPlayer(GameState, Line, Col, Line, NewCol). 

% Verifies if two cells have distinct player, if yes returns yes, otherwise returns no.
% If one of the cells has no player, then it fails.
% distinctPlayer(+GameState, +Line, +Col, +CaptureLine, +CaptureCol)
% +GameState	: The actual game board.
% +Line		: Line of the actual player.
% +Col		: Column of the actual player.
% +CaptureLine	: Line of the player being captured or another cell.
% +CaptureCol	: Col of the player being captured or another cell.
distinctPlayer(GameState, Line, Col, CaptureLine, CaptureCol):-
	getValueInMatrix(GameState, Line, Col, ActualPlayer),
	getValueInMatrix(GameState, CaptureLine, CaptureCol, CapturedPlayer), 
	ActualPlayer \= CapturedPlayer, 
	ActualPlayer \= 0,
	CapturedPlayer\= 0.  
	
% -----------------------------------------------
% Functions for validation of position
% -----------------------------------------------

% validPos(+Line, +Col).
% Checks if the position if valid in a matrix.
% +Line		: Line in matrix.
% +Col 		: Column in matrix.
validPos(Line, Col):-
	validLine(Line),
	validCol(Col).   

validLine(Line):- 
	numberOfLines(NumLines),
	Line >= 0, Line < NumLines. 

validCol(Col):- 
	numberOfCols(NumCols), 
	Col >= 0, Col < NumCols.
