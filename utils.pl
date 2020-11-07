:- use_module(library(lists)).
 


getBoardNumCols([X|_], Cols):- 
	length(X, Cols).  

getBoardNumLines([X|GameState], Lines):-  
	length([X|GameState], Lines). 

getValueInMatrix(GameState, Line, Col, Value):-   
	nth0(Line, GameState, L), 
	nth0(Col, L, Value).

possible_letters_move('w'). 
possible_letters_move('a').
possible_letters_move('s').
possible_letters_move('d').   