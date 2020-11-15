:- consult('singleton.pl').
:- consult('utils.pl').

% ----------------------------------------------------------------
% Horizontal
% ----------------------------------------------------------------

game_over_horizontal(_, StartRow) :-
	numberOfLines(StartRow),
	!, fail.

game_over_horizontal(Board, StartRow) :-
	numberOfCols(NumCells),
	orthogonal_row_length([0, StartRow], Board, NumCells).

game_over_horizontal(Board, StartRow) :-
	NextRow is StartRow + 1,
	game_over_horizontal(Board, NextRow).

game_over_horizontal(Board) :-
	game_over_horizontal(Board, 0).

% ----------------------------------------------------------------
% Vertical
% ----------------------------------------------------------------

game_over_vertical(_, StartCol) :-
	numberOfCols(StartCol),
	!, fail.

game_over_vertical(Board, StartCol) :-
	numberOfLines(NumCells),
	orthogonal_col_length([StartCol, 0], Board, NumCells).

game_over_vertical(Board, StartCol) :-
	NextCol is StartCol + 1,
	game_over_vertical(Board, NextCol).

game_over_vertical(Board) :-
	game_over_vertical(Board, 0).

% ----------------------------------------------------------------
% Game_over(+Board, +LastPlayerMove, -WinnerPlayer)
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
