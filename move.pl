:- use_module(library(lists)).
:- include('utils.pl').
% ----------------------------------------------- 
% 	Init game 	
% ----------------------------------------------- 

move(GameState, [Line-Col, Letter], NewGameState):-   
	getRealInput(GameState, Line, Col, RealLine, RealCol),
	validPos(GameState, RealLine, RealCol),  
	validCapture(GameState, Letter, RealLine, RealCol, CaptureLine, CaptureCol),    
	getValueInMatrix(GameState, RealLine, RealCol, CellCurrValue), 
	replaceInMatrix(GameState, RealLine-RealCol, 0, CurrGameState), 
	replaceInMatrix(CurrGameState, CaptureLine-CaptureCol, CellCurrValue, NewGameState). 


	
% ----------------------------------------------- 
% 	Make movement functions
% ----------------------------------------------- 

getValueInMatrix(GameState, Line, Col, Value):-   
	nth0(Line, GameState, L), 
	nth0(Col, L, Value).

	
replaceInMatrix([L|GameState], Line-Col, NewValue, [L|NewGameState]):- 
	NewLine is Line -1,  
	replaceInMatrix(GameState, NewLine-Col, NewValue, NewGameState).

replaceInMatrix([L|GameState], 0-Col, NewValue, [NewL|GameState]):-
	replaceInList(L, Col, NewValue, NewL). 


/**
 * @brief: Replaces an element from [L|List] in position Pos  
 * for a new value called NewValue.
 */ 
replaceInList([L|List], Pos, NewValue, [L|NewList]):-  
	AuxPos is Pos- 1, 
	replaceInList(List, AuxPos, NewValue, NewList). 

replaceInList([L|List], 0, NewValue, [NewValue|List]).  


% -----------------------------------------------
%	Functions for validation of pos
% -----------------------------------------------


validPos(GameState, Line, Col):-
	validLine(GameState, Line),
	validCol(GameState, Col).   

validLine(GameState, Line):-  
	getBoardNumLines(GameState, NumLines),
	Line >= 0, Line < NumLines. 


validCol(GameState, Col):-  
	getBoardNumCols(GameState, NumCols), 
	Col >= 0, Col < NumCols.
 

% -----------------------------------------------
%	Functions for validation of capture 
% ----------------------------------------------- 


validCapture(GameState, 'w', Line, Col, NewLine, Col):-  !,  
	NewLine is Line +1, 
	validLine(GameState, NewLine).   

validCapture(GameState, 's', Line, Col, NewLine, Col):-  !,  
	NewLine is Line -1, 
	validLine(GameState, NewLine). 

validCapture(GameState, 'd', Line, Col, Line, NewCol):- !, 
	NewCol is Col +1, 
	validCol(GameState, NewCol).  

validCapture(GameState, 'a', Line, Col, Line, NewCol):- !, 
	NewCol is Col -1, 
	validCol(GameState, NewCol). 

% -----------------------------------------------
%	Get Real Input 	
% -----------------------------------------------

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


