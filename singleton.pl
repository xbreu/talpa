% -----------------------------------------------
% Board variables
% -----------------------------------------------

% Determines the number of lines in the game.
numberOfLines(3).

% Determines the number of columns in the game. 
numberOfCols(3).

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
