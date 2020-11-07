:- use_module(library(lists)).
 


getBoardNumCols([X|_], Cols):- 
	length(X, Cols).  

getBoardNumLines([X|GameState], Lines):-  
	length([X|GameState], Lines). 


