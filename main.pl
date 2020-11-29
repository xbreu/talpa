:- consult('game/board/initial.pl').
:- consult('game/bot.pl').
:- consult('game/end.pl').
:- consult('game/player.pl').
:- consult('game/valid_moves.pl').
:- consult('io/board.pl').
:- consult('io/menu.pl').
:- consult('io/victory.pl').
:- consult('utils/utils.pl').

make_move(GameState, 0, Player, NewGameState) :-
	valid_moves_asdw(GameState, Player, ListOfMoves), 		% check if it's necessary to remove a piece
	ListOfMoves \= [], !,
	getMovement(GameState, Player, Row, Column, Direction),
   	move(GameState, [Row-Column, Direction], NewGameState).

make_move(GameState, 0, Player, NewGameState) :-
	getRemoveMovement(GameState, Player, Row, Column),
   	move(GameState, [Row-Column, 'r'], NewGameState).

make_move(GameState, Level, Player, NewGameState) :-
	Level > 0,
	choose_move(GameState, Player, Level, NewGameState).

play :-
	assert(numberOfLines(8)),
	assert(numberOfCols(8)),
	assert(language(en)),
	handle_main_menu(Level1-Level2),
	initial(GameState),
	play(GameState, Level1-Level2, 1).
play.

play(GameState, _, Player) :-
	game_over(Player-GameState, Winner), !,
	display_game(GameState, Player),
	print_winner(Winner).

play(GameState, Levels, Player) :-
	get_level(Levels, Player, Level),
	display_game(GameState, Player),
	make_move(GameState, Level, Player, NewGameState),
	swap_players(Player, NewPlayer),
	play(NewGameState, Levels, NewPlayer).
