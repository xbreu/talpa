:- use_module(library(lists)).
 


getBoardNumCols([X|_], Cols):- !,
	length(X, Cols).  

getBoardNumLines([X|GameState], Lines):-  !,
	length([X|GameState], Lines). 

getValueInMatrix(GameState, Line, Col, Value):- !,
	nth0(Line, GameState, L), 
	nth0(Col, L, Value).

	   