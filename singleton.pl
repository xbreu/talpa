% Determines the number of lines in the game.
numberOfLines(8). 

% Determines the number of columns in the game. 
numberOfCols(8).

% horizontal and vertical players
vertical_player(1).
horizontal_player(2).

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