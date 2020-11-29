:- use_module(library(between)).
:- use_module(library(lists)).
:- consult('../../variables.pl').

% -----------------------------------------------
% Functions for validation of position
% -----------------------------------------------

% validPos(+LineCol).
% Checks if the position if valid in a matrix.
% +Line		: Line in matrix.
% +Col 		: Column in matrix.
validPos(Line, Col):-
	validLine(Line),
	validCol(Col).

validLine(Line):-
	numberOfLines(NumLines),
	Max is NumLines - 1,
	between(0, Max, Line).

validCol(Col):-
	numberOfCols(NumCols),
	Max is NumCols - 1,
	between(0, Max, Col).

% -----------------------------------------------
% Matrix functions
% -----------------------------------------------

empty_cell(Board, Col-Row) :-
	\+getValueInMatrix(Board, Row, Col, 0).

not_empty_cell(Board, Cell) :-
	\+empty_cell(Board, Cell).

% Gets the value inside a matrix.
% getValueInMatrix(+GameState, +Line, +Col, -Value).
% +GameState	: Board of the game.
% +Line			: Line to get the value.
% +Col			: Column to get the value.
% -Value		: The value of the cell in the +Line, +Col position.
getValueInMatrix(GameState, Line, Col, Value):- !,
	nth0(Line, GameState, L),
	nth0(Col, L, Value).

% -----------------------------------------------
% Replace functions
% -----------------------------------------------

% Replaces an element from +Matrix in +Position for a new value called +NewValue.
% replaceInMatrix(+Matrix, +Position, +NewValue, -NewMatrix).
% +Matrix 	: List to be changed.
% +Position 	: Position in +List to change the value.
% +NewValue 	: The new value of the element in List[Position].
% -NewMatrix	: List to be returned.
replaceInMatrix([L|GameState], 0-Col, NewValue, [NewL|GameState]):- !,
	replaceInList(L, Col, NewValue, NewL).
replaceInMatrix([L|GameState], Line-Col, NewValue, [L|NewGameState]):- !,
	NewLine is Line -1,
	NewLine >= 0,
	replaceInMatrix(GameState, NewLine-Col, NewValue, NewGameState).

% Replaces an element from [L|List] in position Pos for a new value called NewValue.
% replaceInList(+List, +Position, +NewValue, -NewList).
% +List 		: List to be changed.
% +Position 	: Position in +List to change the value.
% +NewValue 	: The new value of the element in List[Position].
% -NewList 		: List to be returned.
replaceInList([_|List], 0, NewValue, [NewValue|List]).
replaceInList([L|List], Pos, NewValue, [L|NewList]):- !,
	AuxPos is Pos- 1,
	AuxPos >= 0,
	replaceInList(List, AuxPos, NewValue, NewList).

% ----------------------------------------------------------------
% Adjacency functions
% ----------------------------------------------------------------

% Returns true if the first list and the second are adjacent

% down adjacent
adjacent_cell([StartCol, StartRow], [StartCol, NextRow]) :-
	NextRow is StartRow + 1,
	numberOfLines(Lines),
	NextRow < Lines.

% left adjacent
adjacent_cell([StartCol, StartRow], [NextCol, StartRow]) :-
	NextCol is StartCol + 1,
	numberOfCols(Cols),
	NextCol < Cols.

% top adjacent
adjacent_cell([StartCol, StartRow], [StartCol, PreviousRow]) :-
	PreviousRow is StartRow - 1,
	PreviousRow >= 0.

% right adjacent
adjacent_cell([StartCol, StartRow], [PreviousCol, StartRow]) :-
	PreviousCol is StartCol - 1,
	PreviousCol >= 0.
