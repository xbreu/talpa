% Determines the number of lines in the game.
numberOfLines(3).

% Determines the number of columns in the game. 
numberOfCols(3).

% horizontal and vertical players
vertical_player(1).
horizontal_player(2).

% player codes
code(0,' ').
code(1,'\x00445\').
code(2,'\x25CF\').

% for tests 

medium_game_1(
                 [[1,2,2,2,1], 
                  [0,2,0,2,0], 
                  [2,0,0,2,2],
                  [1,0,1,0,0],
                  [0,1,1,1,1]]).
medium_game_2(
                 [[1,2,1,2,1], 
                  [0,2,0,2,0],
                  [2,0,0,0,2],
                  [0,0,1,0,0],
                  [0,1,1,1,1]]).  