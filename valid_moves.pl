:- include('move.pl'). 

valid_moves(GameState, Player, ListOfMoves):-
        getValueInMatrix(GameState, Line, Col, Player), 
        print(Line), 
        print('\n'), 
        print(Col), 
        print('\n'),
        findall(NewGameState, (move(GameState, [Line-Col, 'w'], NewGameState)), ListOfMoves). 
     
