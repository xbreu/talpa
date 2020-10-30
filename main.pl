:- include('print.pl'). 
:- include('initial.pl').  
:- include('utils.pl').  
:- include('move.pl'). 

% -----------------------------------------------
%	Display game 
% ----------------------------------------------- 

display_game(GameState, Player):-     
	print_matrix(GameState).     

play:- 
	initial(GameState),  
	display_game(GameState, 1).



