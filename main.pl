:- consult('print.pl'). 
:- consult('initial.pl').  
:- consult('utils.pl').  
:- consult('move.pl'). 
:- consult('valid_moves.pl'). 
:- consult('end.pl'). 
:- consult('bot.pl').
:- consult('input.pl').
:- consult('menu.pl').

get_valid_adjacent(Board, Col-Row, Visited, AdjCol-AdjRow) :-
	adjacent_cell([Col, Row], [AdjCol, AdjRow]),
	\+member(AdjCol-AdjRow, Visited),
	getValueInMatrix(Board, AdjRow, AdjCol, 0).

get_first_not_visited(Visited, ActualCol-ActualRow, ActualCol-ActualRow) :-
	validPos(ActualRow, ActualCol),
	nonmember(ActualCol-ActualRow, Visited).

get_first_not_visited(Visited, ActualCol-ActualRow, ResultCol-ResultRow) :-
	Col is ActualCol + 1,
	validPos(ActualRow, Col),
	get_first_not_visited(Visited, Col-ActualRow, ResultCol-ResultRow).

get_first_not_visited(Visited, _-ActualRow, ResultCol-ResultRow) :-
	Row is ActualRow + 1,
	validPos(Row, 0),
	get_first_not_visited(Visited, 0-Row, ResultCol-ResultRow).

get_first_not_visited(Visited, Col-Row) :-
	get_first_not_visited(Visited, 0-0, Col-Row).

find_extreme_values([MinColValue-MinRowValue-MaxColValue-MaxRowValue-Visited | []], MinColValue-MinRowValue-MaxColValue-MaxRowValue, Visited).

find_extreme_values([MCol-MRow-HCol-HRow-Visited | T], MinCol-MinRow-MaxCol-MaxRow, Subvisited) :-
	find_extreme_values(T, Min1Col-Min1Row-Max1Col-Max1Row, SubvisitedAux),
	MinCol is min(MCol, Min1Col),
	MinRow is min(MRow, Min1Row),
	MaxCol is max(HCol, Max1Col),
	MaxRow is max(HRow, Max1Row),
	append(Visited, SubvisitedAux, Subvisited).

calculate_paths(_, CellCol-CellRow, [], Visited, Visited, CellCol-CellRow-CellCol-CellRow).

calculate_paths(Board, _, Adjs, Visited, Subvisited, RealMinCol-RealMinRow-RealMaxCol-RealMaxRow) :-
	member(AdjCol-AdjRow, Adjs),
	calculate_path(Board, AdjCol-AdjRow, Visited, Subvisited, AuxMinCol-AuxMinRow-AuxMaxCol-AuxMaxRow),
	RealMinCol is min(AuxMinCol, AdjCol),
	RealMinRow is min(AuxMinRow, AdjRow),
	RealMaxCol is max(AuxMaxCol, AdjCol),
	RealMaxRow is max(AuxMaxRow, AdjRow).

calculate_path(Board, Col-Row, Visited, Subvisited, MinValueCol-MinValueRow-MaxValueCol-MaxValueRow) :-
	findall(Adj, get_valid_adjacent(Board, Col-Row, [Col-Row | Visited], Adj), AdjacentList),
	findall(Value-Subvisited, calculate_paths(Board, Col-Row, AdjacentList, [Col-Row | Visited], Subvisited, Value), ValueList),
	find_extreme_values(ValueList, MinValueCol-MinValueRow-MaxValueCol-MaxValueRow, SubvisitedAux),
	sort(SubvisitedAux, Subvisited).

calculate_path(Board, Cell, Visited, ExtremeValues) :-
	calculate_path(Board, Cell, [], Visited, ExtremeValues).

find_biggest_lines(_, Visited, 0-0) :-
	numberOfCols(C),
	numberOfLines(L),
	len(Visited, V),
	V is C * L.

find_biggest_lines(Board, Visited, ResultCol-ResultRow) :-
	get_first_not_visited(Visited, Cell),
	calculate_path(Board, Cell, Visited, NewVisited, AuxMinCol-AuxMinRow-AuxMaxCol-AuxMaxRow),
	find_biggest_lines(Board, NewVisited, NewCol-NewRow),
	ResultCol is max(AuxMaxCol, NewCol),
	ResultRow is max(AuxMaxRow, NewRow).

find_biggest_lines(Board, Result) :-
	find_biggest_lines(Board, [], Result).

test_board([[1, 1, 1, 1, 1, 0, 1, 0],
			[1, 1, 0, 1, 0, 1, 1, 0],
			[1, 0, 0, 0, 0, 0, 0, 0],
			[1, 0, 0, 2, 1, 1, 1, 0],
			[1, 0, 1, 0, 0, 0, 1, 0],
			[1, 0, 0, 0, 1, 1, 1, 0],
			[1, 0, 0, 1, 1, 0, 1, 1],
			[1, 1, 1, 1, 0, 1, 1, 0]]).
run_test :-
	test_board(Board),
	find_biggest_lines(Board, Result),
	write(Result).

% -----------------------------------------------
%	Display game 
% ----------------------------------------------- 

display_game(GameState, Player) :-
	print_board(GameState).

% +GameState
% +Level
% +Player
% -NewGameState
make_move(GameState, 0, Player, NewGameState) :-
	printPlayerTurn(Player),
	valid_moves_asdw(GameState, Player, ListOfMoves), 		% check if it's necessary to remove a piece
	ListOfMoves \= [], !, 
	getMovement(GameState, Player, Row, Column, Direction),
   	move(GameState, [Row-Column, Direction], NewGameState).

% We want the player to remove a piece. 
make_move(GameState, 0, Player, NewGameState) :-
	getMovement_r(GameState, Player, Row, Column),
   	move(GameState, [Row-Column, 'r'], NewGameState).

make_move(GameState, Level, Player, NewGameState) :-
	Level > 0,
	choose_move(GameState, Player, Level, NewGameState).

% Returns the level of the current player
get_level(Level1-_, 1, Level1).
get_level(_-Level2, 2, Level2).

play :-
	handle_main_menu(Level1-Level2),
	initial(GameState),
	play(GameState, Level1-Level2, 1).

play(GameState, _, Player) :-
	game_over(Player-GameState, Winner), !,
	display_game(GameState, Player),
	print_winner(Winner).

play(GameState, Levels, Player) :-
	get_level(Levels, Player, Level),
	display_game(GameState, Player),
	make_move(GameState, Level, Player, NewGameState), !,
	NewPlayer is Player mod 2 + 1,
	play(NewGameState, Levels, NewPlayer).

play(GameState, Levels, Player) :-
	print('Invalid move!\n'),
	play(GameState, Levels, Player).

