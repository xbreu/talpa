% -----------------------------------------------
% Board variables
% -----------------------------------------------

% Determines the number of lines in the game.
numberOfLines(8).

% Determines the number of columns in the game. 
numberOfCols(8).

% Size of padding on the board
padding_size(1).

% -----------------------------------------------
% Players variables
% -----------------------------------------------

% horizontal and vertical players
vertical_player(1).
horizontal_player(2).

% empty cell code
code(0,' ') :- !.

% player codes
code(1,'\x00445\') :- !.
code(2,'\x25CF\') :- !.
code(X, X).


game_over_1([[0,2,1,2,1,1,1,2],[0,1,2,1,1,0,0,2],[2,0,0,0,0,0,2,2],[0,0,2,0,1,0,0,0],[1,1,0,2,1,1,0,0],[2,0,1,0,2,1,0,2],[2,0,1,0,2,1,0,2],[1,2,1,1,1,2,2,2],[2,1,2,1,2,1,2,1]]).

game_over_2([[1,1,0,1,0,0,0,2],
[0,0,2,0,1,0,2,0],
[1,0,0,0,1,1,0,1],
[0,1,0,1,2,0,0,1],
[1,0,0,0,0,0,0,0],
[2,2,0,2,0,0,0,0],
[2,2,0,0,0,0,0,0],
[0,1,2,0,2,0,0,2]]).