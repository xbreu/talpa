:- consult('utils.pl'). 

% for the player which wins in the horizontal 
% if we have less cells in the vertical path we sum 1 
% if we have more cells in the biggest horizontal path sum 1 

% biggest_row_length - return start cell and size 
% make the move for the bot 

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




can_visit_adjacent([CurrCol, CurrLine], Visited, Board):-
        \+member([CurrCol, CurrLine], Visited),                                  % Isnt visited yet 
        getValueInMatrix(Board, CurrLine, CurrCol, 0).                          % Check if it's 0     
        
         
        