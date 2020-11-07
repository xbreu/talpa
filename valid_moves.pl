:- include('move.pl'). 

valid_moves(GameState, Player, ListOfMoves):- !,
        findall(NewGameState, (   member(Letter, ['a','s','d','w']), 
                                  getValueInMatrix(GameState, Line, Col, Player),
                                  move(GameState, [Line-Col, Letter], NewGameState)), ListOfMoves). 
     
