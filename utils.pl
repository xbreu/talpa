:- use_module(library(lists)).
 


getBoardNumCols([X|GameState], Cols):- 
	length(X, Cols).  

getBoardNumLines([X|GameState], Lines):-  
	length([X|GameState], Lines). 


