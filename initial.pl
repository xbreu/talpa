% ----------------------------------------------- 
% 	Init game 	
% -----------------------------------------------
/**
 * @brief: to change the size of the board, change the values of this function
 */ 
initial(GameState):- 
	initial(GameState, 5, 5).


/**
 * @param R: Number of rows in the game. 
 * @param C: Number of columns. 
 */
initial([Line|State], R, C):-     
	R > 0, 
	0 is mod(R,2),  
	R1 is R-1,  
	build_line_p1(Line, C),		% Line starting with the player 1  
	initial(State, R1, C). 

initial([Line|State], R, C):-   
	R > 0, 
	1 is mod(R,2), 
	R1 is R-1, 
	build_line_p2(Line,C), 		% Line starting with the player 2
	initial(State, R1, C). 

initial([], 0, C). 

% ----------------------------------------------- 
% 	Build Lines 	
% -----------------------------------------------

build_line_p1([X|L], N):-   
	N > 0, 
	get_element_p1(X, N), 
	N1 is N -1,   
	build_line_p1(L, N1). 

build_line_p1([],0).  

% Another player in the beggining of the line.
build_line_p2([X|L], N):- 
	N > 0, 
	get_element_p2(X, N),
	N1 is N -1, 
	build_line_p2(L, N1).  

build_line_p2([],0). 
 

% ----------------------------------------------- 
% 	Get the value for specific line 
% -----------------------------------------------   

/**
 * @brief: These are functions to understand what should be the current value to be displayed in the list 
 * @param N: Number of the column.  
 * @param X: Player to be displayed. 
 */  

get_element_p1(X, N):-     
	0 is mod(N, 2),  	
	X is 1. 
	
get_element_p1(X, N):-  
	1 is mod(N,2), 
	X is 2. 

get_element_p2(X,N):-
	0 is mod(N,2),  
	X is 2.  

get_element_p2(X,N):- 
	1 is mod(N,2), 
	X is 1. 


