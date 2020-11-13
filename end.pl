:- consult('singleton.pl').
:- consult('utils.pl').

% ----------------------------------------------------------------
% Adjacent Cell
% ----------------------------------------------------------------
adjacent_cell([StartCol, StartRow], [StartCol, NextRow]) :-
	NextRow is StartRow + 1.

adjacent_cell([StartCol, StartRow], [NextCol, StartRow]) :-
	NextCol is StartCol + 1.

adjacent_cell([StartCol, StartRow], [StartCol, PreviousRow]) :-
	PreviousRow is StartRow - 1,
	PreviousRow >= 0.

adjacent_cell([StartCol, StartRow], [PreviousCol, StartRow]) :-
	PreviousCol is StartCol - 1,
	PreviousCol >= 0.

% ----------------------------------------------------------------
% orthogonal path
% ----------------------------------------------------------------
orthogonal_line_row([StartCol, _], _, _) :-
	numberOfCols(StartCol), !.

orthogonal_line_row([StartCol, StartRow], Board, UsedCells) :-
	getValueInMatrix(Board, StartCol, StartRow, 0),
	adjacent_cell([StartCol, StartRow], New),
	nonmember(New, UsedCells),
	orthogonal_line_row(New, Board, [New | UsedCells]).

orthogonal_line_row(X, Board) :-
	orthogonal_line_row(X, Board, []).

orthogonal_line_col([_, StartRow], _, _) :-
	numberOfLines(StartRow), !.

orthogonal_line_col([StartCol, StartRow], Board, UsedCells) :-
	getValueInMatrix(Board, StartCol, StartRow, 0),
	adjacent_cell([StartCol, StartRow], New),
	nonmember(New, UsedCells),
	orthogonal_line_col(New, Board, [New | UsedCells]).

orthogonal_line_col(X, Board) :-
	orthogonal_line_col(X, Board, []).

% ----------------------------------------------------------------
% horizontal
% ----------------------------------------------------------------
game_over_horizontal(_, StartRow) :-
	numberOfLines(StartRow),
	!, fail.

game_over_horizontal(Board, StartRow) :-
	orthogonal_line_row([0, StartRow], Board).

game_over_horizontal(Board, StartRow) :-
	NextRow is StartRow + 1,
	game_over_horizontal(Board, NextRow).

game_over_horizontal(Board) :-
	game_over_horizontal(Board, 0).

% ----------------------------------------------------------------
% vertical
% ----------------------------------------------------------------
game_over_vertical(_, StartCol) :-
	numberOfCols(StartCol),
	!, fail.

game_over_vertical(Board, StartCol) :-
	orthogonal_line_col([StartCol, 0], Board).

game_over_vertical(Board, StartCol) :-
	NextCol is StartCol + 1,
	game_over_vertical(Board, NextCol).

game_over_vertical(Board) :-
	game_over_vertical(Board, 0).

% ----------------------------------------------------------------
% game_over(+Board, +LastPlayerMove, -WinnerPlayer)
% ----------------------------------------------------------------

% if in the last move both players achieve the goal the last player loses
game_over(Board, X, Y) :-
	horizontal_player(X),
	game_over_vertical(Board), !,
	vertical_player(Y).

game_over(Board, X, Y) :-
	vertical_player(X),
	game_over_horizontal(Board), !,
	horizontal_player(Y).

game_over(Board, X, X) :-
	horizontal_player(X),
	game_over_horizontal(Board).

game_over(Board, X, X) :-
	vertical_player(X),
	game_over_vertical(Board).
