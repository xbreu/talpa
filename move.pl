
% ----------------------------------------------- 
% 	Init game 	
% ----------------------------------------------- 

%move(GameState, [Line-Row, NewLine-NewRow], NewGameState):-   



replaceInLine([L|List], Pos, NewValue, [L|NewList]):-  
	AuxPos is Pos- 1, 
	replaceInLine(List, AuxPos, NewValue, NewList). 

replaceInLine([L|List], 0, NewValue, [NewValue|List]).  







	%isMovementValid(GameState, [Line-Row, newLine-NewRow]):-


	
