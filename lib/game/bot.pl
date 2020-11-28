:- consult('../utils.pl').
:- consult('valid_moves.pl'). 

get_valid_adjacent(Board, Col-Row, Visited, AdjCol-AdjRow) :-
	adjacent_cell([Col, Row], [AdjCol, AdjRow]),
	\+member(AdjCol-AdjRow, Visited),
	getValueInMatrix(Board, AdjRow, AdjCol, 0).

get_first_not_visited(Visited, ActualCol-ActualRow, ActualCol-ActualRow) :-
	validPos(ActualRow, ActualCol),
	nonmember(ActualCol-ActualRow, Visited).

get_first_not_visited(Visited, ActualCol-ActualRow, ResultCol-ResultRow) :-
	Col is ActualCol + 1,
	validPos(ActualRow, Col),
	get_first_not_visited(Visited, Col-ActualRow, ResultCol-ResultRow).

get_first_not_visited(Visited, _-ActualRow, ResultCol-ResultRow) :-
	Row is ActualRow + 1,
	validPos(Row, 0),
	get_first_not_visited(Visited, 0-Row, ResultCol-ResultRow).

get_first_not_visited(Visited, Col-Row) :-
	get_first_not_visited(Visited, 0-0, Col-Row).

find_extreme_values([MinColValue-MinRowValue-MaxColValue-MaxRowValue-Visited | []], MinColValue-MinRowValue-MaxColValue-MaxRowValue, Visited).

find_extreme_values([MCol-MRow-HCol-HRow-Visited | T], MinCol-MinRow-MaxCol-MaxRow, Subvisited) :-
	find_extreme_values(T, Min1Col-Min1Row-Max1Col-Max1Row, SubvisitedAux),
	MinCol is min(MCol, Min1Col),
	MinRow is min(MRow, Min1Row),
	MaxCol is max(HCol, Max1Col),
	MaxRow is max(HRow, Max1Row),
	append(Visited, SubvisitedAux, Subvisited).

calculate_paths(_, CellCol-CellRow, [], Visited, [CellCol-CellRow | Visited], CellCol-CellRow-CellCol-CellRow).

calculate_paths(Board, _, Adjs, Visited, Subvisited, RealMinCol-RealMinRow-RealMaxCol-RealMaxRow) :-
	member(AdjCol-AdjRow, Adjs),
	calculate_path(Board, AdjCol-AdjRow, Visited, Subvisited, AuxMinCol-AuxMinRow-AuxMaxCol-AuxMaxRow),
	RealMinCol is min(AuxMinCol, AdjCol),
	RealMinRow is min(AuxMinRow, AdjRow),
	RealMaxCol is max(AuxMaxCol, AdjCol),
	RealMaxRow is max(AuxMaxRow, AdjRow).

calculate_path(Board, Col-Row, Visited, [Col-Row | Visited], 1-1-1-1) :-
	\+getValueInMatrix(Board, Row, Col, 0), !.

calculate_path(Board, Col-Row, Visited, Subvisited, MinValueCol-MinValueRow-MaxValueCol-MaxValueRow) :-
	findall(Adj, get_valid_adjacent(Board, Col-Row, [Col-Row | Visited], Adj), AdjacentList),
	findall(Value-Subvisited, calculate_paths(Board, Col-Row, AdjacentList, [Col-Row | Visited], Subvisited, Value), ValueList),
	find_extreme_values(ValueList, MinValueCol-MinValueRow-MaxValueCol-MaxValueRow, SubvisitedAux),
	sort(SubvisitedAux, Subvisited).

calculate_path(Board, Cell, Visited, ExtremeValues) :-
	calculate_path(Board, Cell, [], Visited, ExtremeValues).

find_biggest_lines(_, _, Visited, 0-0) :-
	numberOfCols(C),
	numberOfLines(L),
	length(Visited, V),
	V is C * L, !.

find_biggest_lines(Board, LastCell, Visited, ResultCol-ResultRow) :-
	get_first_not_visited(Visited, LastCell, Cell),
	calculate_path(Board, Cell, [], AuxNewVisited, AuxMinCol-AuxMinRow-AuxMaxCol-AuxMaxRow),
	append(Visited, AuxNewVisited, NewVisited),
	find_biggest_lines(Board, Cell, NewVisited, NewCol-NewRow),
	AuxCol is AuxMaxCol - AuxMinCol + 1,
	AuxRow is AuxMaxRow - AuxMinRow + 1,
	ResultCol is max(AuxCol, NewCol),
	ResultRow is max(AuxRow, NewRow).

get_all_values(Board, HorizontalValue, VerticalValue) :-
	find_biggest_lines(Board, 0-0, [], HorizontalValue-VerticalValue), !.

% -----------------------------------------------
%  Choose move         
% -----------------------------------------------

% Choose a move for the pc according to the level.
%
% choose_move(+GameState, +Player, +Level, -Move).
% +GameState     : Current board of the game.
% +Player        : Current player.
% +Level         : Difficulty level.
% -Move          : The move chosen randomly, but according to the level.
choose_move(GameState, Player, 1, Move):-
        valid_moves(GameState, Player, ListOfMoves),   
        random_list(ListOfMoves, Move), !. 

choose_move(GameState, Player, Level, Move):- !,
        valid_moves(GameState, Player, ListOfMoves),     																% get all possible moves
        setof(Value-NextState, (member(NextState, ListOfMoves), value(NextState, Player, Value)), ValuesMovesList),     % get game moves and its respectives values
        setof(Value, Z^member(Value-Z, ValuesMovesList), ValuesList),                                                   % get set of values
        choose_value_by_level(ValuesList, Level, ValueChosen),                                                          % value of which will be chosen the gamestate
        choose_moves_by_value(ValuesMovesList, ValueChosen, MovesList),                                                 % list of moves with value chosen in the previous line
        random_list(MovesList, Move).                                                                                   % choose state by the value, randomly

% Get a list of moves with a specific value.
%
% choose_moves_by_value(+ValuesMovesList, +ValueChosen, -MovesList).
% +ValuesMovesList       : List with all possible moves and its values.
% +ValueChosen           : Lists with this value will be selected.
% -MovesList             : List of moves with the given value.
choose_moves_by_value([], _, []). 
choose_moves_by_value([Value-Move|ValuesMovesList], ValueChosen, [Move|MovesList]):-
        Value == ValueChosen, 
        choose_moves_by_value(ValuesMovesList, ValueChosen, MovesList),!. 

choose_moves_by_value([Value-_|ValuesMovesList], ValueChosen, MovesList):- 
        Value \= ValueChosen, 
        choose_moves_by_value(ValuesMovesList, ValueChosen, MovesList). 

% From the values give, choose the Level th value from the list of values. If Level > values.size, the the chosen value will be the last element from the list.
% choose_value_by_level(+ValuesList, +Level, -Value).
% +ValuesList            : Set of values.
% +Level                 : Level chosen.
% -Value                 : Retrieved value.
choose_value_by_level(ValuesList, Level, Value):-
        length(ValuesList, Size),
        Pos is (Size + Level - 9), !,  
        NewPos is max(Pos, 1), 
        nth1(NewPos, ValuesList, Value).

% ----------------------------------------------- 
%  Valuate        
% -----------------------------------------------

% Value of the GameState. Formula: sizeOfPathHorizontal*NumCellsInPath - sizeOfPathVertical*NumCellsInPath
% value(+GameState, +Player, -Value).
% +GameState     : Actual board state.
% +Player        : Number of the actual player 1 or 2.
% +Value         : Value of the board.
value(GameState, Player, Value):-
        horizontal_player(Player),
       	get_all_values(GameState, HorizontalValue, VerticalValue),
        Value is HorizontalValue - VerticalValue.

value(GameState, Player, Value):-
        vertical_player(Player),
        get_all_values(GameState, HorizontalValue, VerticalValue),
        Value is VerticalValue - HorizontalValue.
          
% ----------------------------------------------- 
%  Orthogonal length        
% -----------------------------------------------

% Get's the honrizontal length of a path.
% orthogonal_row_length([+StartCol, +StartLine], +Board, -NumCells).
% +StartCol      : Col where the path starts.
% +StartLine     : Line where the path starts.
% +Board         : GameState.
% -NumCells      : Horizontal length in cells measure.
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

% Get's the Vertical length of a path.
% orthogonal_col_length([+StartCol, +StartLine], +Board, -NumCells).
% +StartCol      : Col where the path starts.
% +StartLine     : Line where the path starts.
% +Board         : GameState.
% -NumCells      : Vertical length in cells measure.
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

% A cell can be visited if wasn't visited
can_visit_adjacent([CurrCol, CurrLine], Visited, Board):-
        \+member([CurrCol, CurrLine], Visited),                                  % Isnt visited yet 
        getValueInMatrix(Board, CurrLine, CurrCol, 0).                           % Check if it's 0     
        
         
        