:- consult('print.pl'). 
:- consult('initial.pl').  
:- consult('utils.pl').  
:- consult('move.pl'). 
:- consult('valid_moves.pl'). 
:- consult('end.pl'). 
:- consult('bot.pl').
:- consult('input.pl').
:- consult('menu.pl'). 

% -----------------------------------------------
%	Display game 
% ----------------------------------------------- 

display_game(GameState, Player) :-
	print_board(GameState).

print_winner(Winner) :-
	print('Player '),
	print(Winner),
	print(' wins'),
	nl.

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
	% handle_main_menu(Level1-Level2),
	Level1 is 0,
	Level2 is 0,
	initial(GameState),
	play(GameState, Level1-Level2, 1).

play(GameState, _, Player) :-
	game_over(GameState, Player, Winner), !,
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

