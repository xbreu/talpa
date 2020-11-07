:- use_module(library(lists)).
:- include('utils.pl').
% ----------------------------------------------- 
% 	Init game 	
% ----------------------------------------------- 

move(GameState, [RealLine-RealCol, Letter], NewGameState):-   
	validPos(GameState, RealLine, RealCol),  
	validCapture(GameState, Letter, RealLine, RealCol, CaptureLine, CaptureCol),    
	print(CaptureLine), 
	print(CaptureCol),
	getValueInMatrix(GameState, RealLine, RealCol, CellCurrValue), 
	replaceInMatrix(GameState, RealLine-RealCol, 0, CurrGameState), 
	replaceInMatrix(CurrGameState, CaptureLine-CaptureCol, CellCurrValue, NewGameState). 


	
% ----------------------------------------------- 
% 	Make movement functions
% ----------------------------------------------- 


	
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

replaceInList([_|List], 0, NewValue, [NewValue|List]).  


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
	NewLine is Line -1, 
	validLine(GameState, NewLine),
	distinctPlayer(GameState, Line, Col, NewLine, Col).
	

validCapture(GameState, 's', Line, Col, NewLine, Col):-  !,  
	NewLine is Line +1, 
	validLine(GameState, NewLine),
	distinctPlayer(GameState, Line, Col, NewLine, Col). 

validCapture(GameState, 'd', Line, Col, Line, NewCol):- !, 
	NewCol is Col +1, 
	validCol(GameState, NewCol),
	distinctPlayer(GameState, Line, Col, Line, NewCol).  

validCapture(GameState, 'a', Line, Col, Line, NewCol):- !, 
	NewCol is Col -1, 
	validCol(GameState, NewCol),
	distinctPlayer(GameState, Line, Col, Line, NewCol). 


distinctPlayer(GameState, Line, Col, CaptureLine, CaptureCol):-
	getValueInMatrix(GameState, Line, Col, ActualPlayer),
	getValueInMatrix(GameState, CaptureLine, CaptureCol, CapturedPlayer), 
	ActualPlayer \= CapturedPlayer, 
	ActualPlayer \= 0,
	CapturedPlayer\= 0.  
	

