:-consult('input.pl').

handle_main_menu(Level_X-Level_O) :-
        display_main_menu, 
        getInputInt('Choose a option [1-2] >> ', 1, 3, Option), 
        handle_main_menu_options(Option, Level_X-Level_O).

% to change. 
handle_main_menu_options(1, Level):- !,
        handle_level_menu(Level). 
        % call the game. 
       
% Exit 
handle_main_menu_option(2, _):-
        halt. 

handle_level_menu(Level_X-Level_O):-
        display_level_menu(1), 
        getInputInt('Choose a level [1-9] or type 0 >>', 0 , 10, Level_X),
        display_level_menu(2), 
        getInputInt('Choose a level [1-9] or type 0>>', 0 , 10, Level_O).


% ----------------------------------------------- 
% Main menu print
% -----------------------------------------------

display_main_menu :-
        display_main_title,
        display_main_options. 

display_main_title :-
        menu_delimitation, nl,
        menu_empty_line, nl,                              
        write('|        _ __ ___     ___   _ __    _   _         |'     ), nl,
        write('|       | \'_ ` _ \\   / _ \\ | \'_ \\  | | | |        |'), nl,
        write('|       | | | | | | |  __/ | | | | | |_| |        |'     ), nl,
        write('|       |_| |_| |_|  \\___| |_| |_|  \\__,_|        |'   ), nl,
        menu_empty_line, nl,
        menu_empty_line, nl,
        menu_empty_line, nl.  


display_main_options :-
        menu_empty_line, nl, 
        write('|              1) Play                            |'),nl,
        write('|              2) Exit                            |'),nl, 
        menu_empty_line                                             ,nl,
        menu_delimitation                                           ,nl. 
        
% ----------------------------------------------- 
%  Level Menu        
% ----------------------------------------------- 

display_level_menu(Player) :-
        display_level_title,
        display_level_options(Player). 

display_level_title :-
        menu_delimitation, nl,
        menu_empty_line, nl, 
        write('|          _                         _            |        '),nl, 
        write('|         | |                       | |           |        '),nl,        
        write('|         | |   ___  __   __   ___  | |           |        '),nl,
        write('|         | |  / _ \\ \\ \\ / /  / _ \\ | |           |    '),nl,
        write('|         | | |  __/  \\ V /  |  __/ | |           |       '),nl,
        write('|         |_|  \\___|   \\_/    \\___| |_|           |     '),nl,
        menu_empty_line, nl,
        menu_empty_line, nl,
        menu_empty_line, nl.  
   
display_level_options(Player) :-
        code(Player, Code), 
        menu_empty_line, nl, 
        format('|         CONFIGURATIONS FOR PLAYER ~w             |        ', Code),nl,
        menu_empty_line, nl, 
        write('|  - To play as HUMAN type 0.                     |        '),nl,
        write('|  - To choose a BOT type the level [\'1-9\']       |        '),nl,
        write('|  - If two digits are written, just the first    |        '),nl,
        write('|    one will be considered                       |        '),nl,

        menu_empty_line, nl, 
        menu_empty_line, nl, 
        menu_delimitation, nl. 


menu_empty_line :-
        write('|                                                 |'). 

menu_delimitation :-
        write('*-------------------------------------------------*'). 



