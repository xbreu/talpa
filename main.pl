:- include('print.pl'). 
:- include('initial.pl'). 

% -----------------------------------------------
%	Display game 
% ----------------------------------------------- 

display_game(S, P):-    
	print_matrix(S).     

display_init:- 
	initial(S),
	display_game(S, 1).



