
getRealLine(GameState, Line, RealLine):-  
	boardNumLines(GameState, NumLines), 
	RealLine is NumLines - Line. 

getRealCol(Col, RealCol):-
	char_code(Col, X),    
	RealCol is X-97. 

		

