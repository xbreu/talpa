:- include('print.pl'). 
:- include('initial.pl'). 

% -----------------------------------------------
%	Display game 
% ----------------------------------------------- 

display_game(S, P):-     
	print_matrix(S).     

play:-  
	initial(S),
	display_game(S, 1).


% Representation of begin, intermediate and end final game. 
% This representations are merly symbolic. 
intial_state:- 
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


