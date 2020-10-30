:- use_module(library(lists)).
 


boardNumCols([X|GameState], Cols):- 
	length(X, Cols).  

boardNumLines([X|GameState], Lines):-  
	length([X|GameState], Lines). 


