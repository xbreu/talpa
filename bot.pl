:- consult('utils.pl'). 
:- consult('valid_moves.pl'). 
:- use_module(library(random)). 

% ----------------------------------------------- 
%  Choose move         
% -----------------------------------------------

choose_move(GameState, Player, Level, Moves):- 
        valid_moves(GameState, Player, ListOfMoves),                                                                    % get all possible moves 
        setof(Value-NextState, (member(NextState, ListOfMoves),value(NextState, Player, Value)), ValuesMovesList),      % associate values and gamestates for the possible moves 
        setof(Value, member(Value-_, ValuesMovesList), ValuesList),                                                     % get set of list of values
        choose_value_by_level(ValuesList, Level, ValueChoosen),                                                         % value of which will be chosen the gamestate.
        choose_moves_by_level(ValuesMovesList, ValueChoosen, MovesList),                                                 % list of moves with value chosen in the previous line 
        get_move_by_value(ValuesMovesList, Level, ValueChoosen, Move).                                                  % choose state by the value, randomly 



choose_moves_by_value([], _, []). 
choose_moves_by_value([Value-Move|ValuesMovesList], ValueChosen, [Move|MovesList]):-
        Value == ValueChosen, 
        choose_move_by_value(ValuesMovesList, ValueChosen, MovesList),!. 

choose_moves_by_value([Value-_|ValuesMovesList], ValueChosen, MovesList):- 
        Value \= ValueChosen, 
        choose_move_by_value(ValuesMovesList, ValueChosen, MovesList). 
          
                                                 

choose_value_by_level(ValuesList, Level, Value):-
        len(ValuesList, Size), 
        Size =< Level, 
        nth1(Size, ValuesList, Value). 

choose_value_by_level(ValuesList, Level, Value):- 
        len(ValuesList, Size), 
        Size > Level, 
        nth1(Level, ValuesList, Value). 
        



% ----------------------------------------------- 
%  Valuate        
% -----------------------------------------------
/* 
 Value of the GameState. Formula: sizeOfPathHorizontal*NumCellsInPath - sizeOfPathVertical*NumCellsInPath

 value(+GameState, +Player, -Value).
 +GameState     : Actual board state. 
 +Player        : Number of the actual player 1 or 2. 
 +Value         : Value of the board.        
*/ 
value(GameState, Player, Value):- 
        horizontal_player(Player), 
        
        findall(NumCells, (
                              getValueInMatrix(GameState, StartLine, StartCol, 0), 
                              orthogonal_row_length([StartCol, StartLine], GameState, NumCells)),
                HorizontalValues), 
        sumList(HorizontalValues, HorizontalValue),
        
        findall(NumCells, (
                      getValueInMatrix(GameState, StartLine, StartCol, 0), 
                      orthogonal_col_length([StartCol, StartLine], GameState, NumCells)),
        VerticalValues),
        
        sumList(VerticalValues, VerticalValue),
        Value is HorizontalValue - VerticalValue. 

value(GameState, Player, Value):-
        vertical_player(Player), 
        horizontal_player(HPlayer), 
        value(GameState, HPlayer, OpositeValue), 
        Value is 0 - OpositeValue. 
          
% ----------------------------------------------- 
%  Orthogonal length        
% -----------------------------------------------

/**
 Get's the honrizontal length of a path. 

 orthogonal_row_length([+StartCol, +StartLine], +Board, -NumCells).
 +StartCol      : Col where the path starts. 
 +StartLine     : Line where the path starts. 
 +Board         : GameState. 
 -NumCells      : Horizontal length in cells measure. 
*/ 
orthogonal_row_length([StartCol, StartLine], Board, NumCells):-
        can_visit_adjacent([StartCol, StartLine], [], Board),
        orthogonal_row_length([StartCol, StartLine], Board, [], NumCells, 1), !. 

% If the first cell is not 0, e cannot visit it. So the NumCells is 0. 
orthogonal_row_length([CurrCol, CurrLine], Board, 0):-                  
        \+can_visit_adjacent([CurrCol, CurrLine], [], Board). 

     
% The next cell we can visit adds an horizontal cell. 
orthogonal_row_length([CurrCol, CurrLine], Board, Visited, NumCells, AccNumCells):-
        adjacent_cell([CurrCol, CurrLine], [NewCol, NewLine]),
        can_visit_adjacent([NewCol, NewLine], Visited, Board),          
        is_adjacent_in_row([CurrCol, CurrLine], [NewCol, NewLine]), !,  
        NewAccNumCells is AccNumCells +1, 
        orthogonal_row_length([NewCol, NewLine], Board, [[CurrCol, CurrLine]|Visited], NumCells, NewAccNumCells).  
                    
% The next cell we can visit doesn't add an horizontal cell. 
orthogonal_row_length([CurrCol, CurrLine], Board, Visited, NumCells, AccNumCells):-
        adjacent_cell([CurrCol, CurrLine], [NewCol, NewLine]),
        can_visit_adjacent([NewCol, NewLine], Visited, Board),          
        \+is_adjacent_in_row([CurrCol, CurrLine], [NewCol, NewLine]), !,  
        orthogonal_row_length([NewCol, NewLine], Board, [[CurrCol, CurrLine]|Visited], NumCells, AccNumCells).  

% If no other cell can be visit, ends the recursion. 
orthogonal_row_length([_, _], _, _, NumCells, NumCells). 



/**
 Get's the Vertical length of a path. 

 orthogonal_col_length([+StartCol, +StartLine], +Board, -NumCells).
 +StartCol      : Col where the path starts. 
 +StartLine     : Line where the path starts. 
 +Board         : GameState. 
 -NumCells      : Vertical length in cells measure. 
*/ 
orthogonal_col_length([StartCol, StartLine], Board, NumCells):-
        can_visit_adjacent([StartCol, StartLine], [], Board),
        orthogonal_col_length([StartCol, StartLine], Board, [], NumCells, 1), !. 

% If the first cell is not 0, e cannot visit it. So the NumCells is 0. 
orthogonal_col_length([CurrCol, CurrLine], Board, 0):-                  
        \+can_visit_adjacent([CurrCol, CurrLine], [], Board). 

     
% The next cell we can visit adds an horizontal cell. 
orthogonal_col_length([CurrCol, CurrLine], Board, Visited, NumCells, AccNumCells):-
        adjacent_cell([CurrCol, CurrLine], [NewCol, NewLine]),
        can_visit_adjacent([NewCol, NewLine], Visited, Board),          
        is_adjacent_in_col([CurrCol, CurrLine], [NewCol, NewLine]), !,  
        NewAccNumCells is AccNumCells +1, 
        orthogonal_col_length([NewCol, NewLine], Board, [[CurrCol, CurrLine]|Visited], NumCells, NewAccNumCells).  
                    
% The next cell we can visit doesn't add an horizontal cell. 
orthogonal_col_length([CurrCol, CurrLine], Board, Visited, NumCells, AccNumCells):-
        adjacent_cell([CurrCol, CurrLine], [NewCol, NewLine]),
        can_visit_adjacent([NewCol, NewLine], Visited, Board),          
        \+is_adjacent_in_col([CurrCol, CurrLine], [NewCol, NewLine]), !,  
        orthogonal_col_length([NewCol, NewLine], Board, [[CurrCol, CurrLine]|Visited], NumCells, AccNumCells).  

% If no other cell can be visit, ends the recursion. 
orthogonal_col_length([_, _], _, _, NumCells, NumCells). 

/**
 A cell can be visited if wasn't visited 
*/ 
can_visit_adjacent([CurrCol, CurrLine], Visited, Board):-
        \+member([CurrCol, CurrLine], Visited),                                  % Isnt visited yet 
        getValueInMatrix(Board, CurrLine, CurrCol, 0).                           % Check if it's 0     
        
         
        