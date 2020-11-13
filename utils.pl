:- use_module(library(lists)).
:- consult('singleton.pl'). 






random_list(List, Element):-
        len(List, X), 
        random(0, X, R), 
        nth0(R, List, Element).  



sumList([], 0). 
sumList([X|L], Sum):-
	sumList(L, NewSum), 
	Sum is NewSum +X. 

/**
 Gets the value inside a matrix. 

 getValueInMatrix(+GameState, +Line, +Col, -Value) 
 +GameState	: Board of the game. 
 +Line		: Line to get the value. 
 +Col		: Column to get the value. 
 -Value		: The value of the cell in the +Line, +Col position. 
*/ 
getValueInMatrix(GameState, Line, Col, Value):- !,
	nth0(Line, GameState, L), 
	nth0(Col, L, Value).



% ----------------------------------------------- 
%  Replace functions  	
% ----------------------------------------------- 

/**
 Replaces an element from +Matrix in +Position for a new value called +NewValue.

 replaceInMatrix(+Matrix, +Position, +NewValue, -NewMatrix).
 +Matrix 	: List to be changed. 
 +Position 	: Position in +List to change the value.
 +NewValue 	: The new value of the element in List[Position]. 
 -NewMatrix	: List to be returned.  

 */ 

replaceInMatrix([L|GameState], 0-Col, NewValue, [NewL|GameState]):- !, 
	replaceInList(L, Col, NewValue, NewL). 

replaceInMatrix([L|GameState], Line-Col, NewValue, [L|NewGameState]):- !, 
	NewLine is Line -1,  
	NewLine >= 0,
	replaceInMatrix(GameState, NewLine-Col, NewValue, NewGameState).


/**
 Replaces an element from [L|List] in position Pos for a new value called NewValue.

 replaceInList(+List, +Position, +NewValue, -NewList).
 +List 		: List to be changed. 
 +Position 	: Position in +List to change the value.
 +NewValue 	: The new value of the element in List[Position]. 
 -NewList 	: List to be returned.  

 */ 
replaceInList([_|List], 0, NewValue, [NewValue|List]). 
replaceInList([L|List], Pos, NewValue, [L|NewList]):- !,
	AuxPos is Pos- 1, 
	AuxPos >= 0, 
	replaceInList(List, AuxPos, NewValue, NewList). 

 
% ----------------------------------------------------------------
% Adjacent Cell
% ----------------------------------------------------------------

% Function that get's all the adjacents positions
adjacent_cell([StartCol, StartRow], [StartCol, NextRow]) :-
	NextRow is StartRow + 1, 
	numberOfLines(Lines), 
	NextRow < Lines. 

adjacent_cell([StartCol, StartRow], [NextCol, StartRow]) :-
	NextCol is StartCol + 1,
	numberOfCols(Cols),  
	NextCol < Cols.

adjacent_cell([StartCol, StartRow], [StartCol, PreviousRow]) :-
	PreviousRow is StartRow - 1,
	PreviousRow >= 0.

adjacent_cell([StartCol, StartRow], [PreviousCol, StartRow]) :-
	PreviousCol is StartCol - 1,
	PreviousCol >= 0.

% Checks if two cells are adjacents in a row. 
is_adjacent_in_row([StartCol, StartRow], [NextCol, StartRow]):-
	NextCol is StartCol +1, !. 

is_adjacent_in_row([StartCol, StartRow], [PreviousCol, StartRow]):-
	PreviousCol is StartCol -1.

% Cheks if two cells are adjacents in a col. 
is_adjacent_in_col([StartCol, StartRow], [StartCol, NextRow]):- 
	NextRow is StartRow +1, !. 

is_adjacent_in_col([StartCol, StartRow], [StartCol, PreviousRow]):-
	PreviousRow is StartRow -1. 