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
game_over(Player-Board, Winner) :-
	horizontal_player(Player),
	game_over_vertical(Board), !,
	vertical_player(Winner).

game_over(Player-Board, Winner) :-
	vertical_player(Player),
	game_over_horizontal(Board), !,
	horizontal_player(Winner).

game_over(Player-Board, Player) :-
	horizontal_player(Player),
	game_over_horizontal(Board).

game_over(Player-Board, Player) :-
	vertical_player(Player),
	game_over_vertical(Board).


% ----------------------------------------------- 
%  End Game Display        
% ----------------------------------------------- 

display_x_wins :- 
	write('         _                                                       _                 _ '), nl,
	write(' _ __   | |   __ _   _   _    ___   _ __    __  __   __      __ (_)  _ __    ___  | |'), nl,
	write('| \'_ \\  | |  / _\` | | | | |  / _ \\ | \'__|   \\ \\/ /   \\ \\ /\\ / / | | | \'_ \\  / __| | |'), nl,
	write('| |_) | | | | (_| | | |_| | |  __/ | |       >  <     \\ V  V /  | | | | | | \\__ \\ |_|'), nl,
	write('| .__/  |_|  \\__,_|  \\__, |  \\___| |_|      /_/\\_\\     \\_/\\_/   |_| |_| |_| |___/ (_)'), nl,
	write('|_|                  |___/                                                           ').
		      

display_o_wins :-
	write('          _                                    ___                 _                 _ '), nl,
	write('  _ __   | |   __ _   _   _    ___   _ __     / _ \\    __      __ (_)  _ __    ___  | |'), nl,
	write(' | \'_ \\  | |  / _` | | | | |  / _ \\ | \'__|   | | | |   \\ \\ /\\ / / | | | \'_ \\  / __| | |'), nl,
	write(' | |_) | | | | (_| | | |_| | |  __/ | |      | |_| |    \\ V  V /  | | | | | | \\__ \\ |_|'), nl,
	write(' | .__/  |_|  \\__,_|  \\__, |  \\___| |_|       \\___/      \\_/\\_/   |_| |_| |_| |___/ (_)'), nl,
	write(' |_|                  |___/                                                                  ').






     
           