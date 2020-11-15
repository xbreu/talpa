
% ----------------------------------------------- 
%  Main menu       
% ----------------------------------------------- 
main_menu:-
        main_title,
        main_options. 

main_title:-
        menu_delimitation, nl,
        menu_empty_line, nl,                              
        write('|        _ __ ___     ___   _ __    _   _         |'     ), nl,
        write('|       | \'_ ` _ \\   / _ \\ | \'_ \\  | | | |        |'), nl,
        write('|       | | | | | | |  __/ | | | | | |_| |        |'     ), nl,
        write('|       |_| |_| |_|  \\___| |_| |_|  \\__,_|        |'   ), nl,
        menu_empty_line, nl,
        menu_empty_line, nl,
        menu_empty_line, nl.  


main_options:-
        menu_empty_line, nl, 
        write('|              1) Play                            |'),nl,
        write('|              2) Choose level [default=0]        |'),nl, 
        write('|              3) Exit                            |'),nl, 
        menu_empty_line                                             ,nl,
        menu_delimitation                                           ,nl. 
        
% ----------------------------------------------- 
%  Level Menu        
% ----------------------------------------------- 

level_menu:-
        level_title,
        level_options. 

level_title:- 
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
   
level_options:- 
        menu_empty_line, nl, 
        write('|  Choose a value for the for the level [\'0-9\']   |        '),nl,
        write('|  * If two digits are written, just the first one  |        '),nl,
        write('|    will be considered|                            |        '),nl,
        menu_empty_line, nl, 
        menu_empty_line, nl, 
        menu_delimitation. 


menu_empty_line:-
        write('|                                                 |'). 

menu_delimitation:-
        write('*-------------------------------------------------*'). 
