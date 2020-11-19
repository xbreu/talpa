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
	print_matrix(GameState).


play :-
	handle_main_menu(Level),
	initial(GameState),
	play(GameState, Level, 1).

play(GameState, _, Player) :-
	game_over(Player-GameState, Winner), !,
	display_game(GameState, Player),
	print('Player '), print(Winner), print(' wins'), nl.

make_move(GameState, _, 1, NewGameState) :-
	printPlayerTurn(1),
	display_game(GameState, 1),
	valid_moves_asdw(GameState, 1, ListOfMoves), 		% check if it's necessary to remove a piece
	ListOfMoves \= [], !, 
	getMovement(GameState, 1, Row, Column, Direction),
   	move(GameState, [Row-Column, Direction], NewGameState).

% We want the player to remove a piece. 
make_move(GameState, _, 1, NewGameState) :-
	getMovement_r(GameState, 1, Row, Column),
   	move(GameState, [Row-Column, 'r'], NewGameState).


make_move(GameState, Level, 2, NewGameState) :-
	choose_move(GameState, 2, Level, NewGameState).

play(GameState, Level, Player) :-
	make_move(GameState, Level, Player, NewGameState), !,
	NewPlayer is Player mod 2 + 1,
	play(NewGameState, Level, NewPlayer).

play(GameState, Level, Player) :-
	print('Invalid move!\n'),
	play(GameState, Level, Player).

initial_state :-
	nl,
	format('-- Turn of player ~d --', 1), 
	nl,
	play. 

medium_game :-
	nl, 
	format('-- Turn of player ~d --', 1),  
	nl,
	display_game([[1,2,2,2,1], [0,2,0,2,0], [2,0,0,2,2],[1,0,1,0,0],[0,1,1,1,1], [2,0,0,2,2],[1,0,1,0,0],[0,1,1,1,1]], 1).  

final_game :-
	nl, 
	format('-- Player ~d won --', 2),  
	nl,
	display_game([[1,2,2,2,1], [0,2,0,0,0], [2,0,0,2,2],[0,0,1,0,0],[0,1,1,1,1]], 1). 


