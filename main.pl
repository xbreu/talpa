:- include('print.pl'). 
:- include('initial.pl').  
:- include('utils.pl').  
:- include('move.pl'). 
:- include('valid_moves.pl'). 

% -----------------------------------------------
%	Display game 
% ----------------------------------------------- 

display_game(GameState, Player):-     
	print_matrix(GameState).     

play:- 
	initial(GameState),  
	display_game(GameState, 1).


% Representation of begin, intermediate and end final game. 
% This representations are merly symbolic. 
initial_state:- 
	nl,
	format('-- Turn of player ~d --', 1), 
	nl,
	play. 

medium_game:-  
	nl, 
	format('-- Turn of player ~d --', 1),  
	nl,
	display_game([[1,2,2,2,1], [0,2,0,2,0], [2,0,0,2,2],[1,0,1,0,0],[0,1,1,1,1]], 1).  

final_game:-   
	nl, 
	format('-- Player ~d won --', 2),  
	nl,
	display_game([[1,2,2,2,1], [0,2,0,0,0], [2,0,0,2,2],[0,0,1,0,0],[0,1,1,1,1]], 1). 


