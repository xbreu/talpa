
% ----------------------------------------------- 
%  Main menu       
% ----------------------------------------------- 
main_menu:-
        title,
        main_options. 

title:-
menu_delimitation, nl,
menu_empty_line, nl,                              
write('|        _ __ ___     ___   _ __    _   _         |'     ), nl,
write('|       | \'_ ` _ \\   / _ \\ | \'_ \\  | | | |        |'), nl,
write('|       | | | | | | |  __/ | | | | | |_| |        |'     ), nl,
write('|       |_| |_| |_|  \\___| |_| |_|  \\__,_|        |'   ), nl,
menu_empty_line, nl,
menu_empty_line, nl,
menu_empty_line, nl.  

menu_empty_line:-
        write('|                                                 |'). 

menu_delimitation:-
        write('*-------------------------------------------------*'). 

main_options:-
menu_empty_line, nl, 
write('|                1) Play                          |'),nl,
write('|                2) Choose level                  |'),nl, 
write('|                3) Exit                          |'),nl, 
menu_empty_line,nl,
menu_delimitation, nl. 
        
        
