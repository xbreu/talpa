% -----------------------------------------------
% Interface variables
% -----------------------------------------------

% Determines the language of the text.
dynamic(language/1).

% -----------------------------------------------
% Board variables
% -----------------------------------------------

% Determines the number of lines in the game
numberOfLines(8).

% Determines the number of columns in the game
numberOfCols(8).

% Size of padding on the board
padding_size(1).

% -----------------------------------------------
% Player variables
% -----------------------------------------------

% horizontal and vertical players
vertical_player(1).
horizontal_player(2).

% empty cell code
code(0,' ') :- !.

% player codes
code(1,'\x00445\') :- !.
code(2,'\x25CF\') :- !.

% if the cell does not have a piece of any player and is not empty prints the value itself
code(X, X).
