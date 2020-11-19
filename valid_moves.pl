:- consult('move.pl'). 

/**
 Returns all the possible moves for a player. 
 
 valid_moves(+GameState, +Player, -ListOfMoves). 
 +GameState     : Actual matrix of the game. 
 +Player        : The actual player to move. 
 -ListOfMoves   : List of all possible next states for the game.
*/
valid_moves(GameState, Player, ListOfMoves):- 
        valid_moves_asdw(GameState, Player, ListOfMoves), 
        ListOfMoves \= [], !. 


%TODO: test this function. 
valid_moves(GameState, Player, ListOfMoves):- !,
        findall(NewGameState, (   member(Letter, ['r']), 
                                  getValueInMatrix(GameState, Line, Col, Player),
                                  move(GameState, [Line-Col, Letter], NewGameState)), ListOfMoves). 

% just get moves for the direction aswd. 
valid_moves_asdw(GameState, Player, ListOfMoves):- 
        findall(NewGameState, (   member(Letter, ['a','s','d','w']), 
                                  getValueInMatrix(GameState, Line, Col, Player),
                                  move(GameState, [Line-Col, Letter], NewGameState)), ListOfMoves). 