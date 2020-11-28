:- consult('../variables.pl').

print_winner(Winner) :-
	language(Language),
	display_winner(Language, Winner).

% ----------------------------------------------------------------
% English
% ----------------------------------------------------------------
display_winner(en, 1) :-
	write('         _                                                       _                 _ '), nl,
	write(' _ __   | |   __ _   _   _    ___   _ __    __  __   __      __ (_)  _ __    ___  | |'), nl,
	write('| \'_ \\  | |  / _\` | | | | |  / _ \\ | \'__|   \\ \\/ /   \\ \\ /\\ / / | | | \'_ \\  / __| | |'), nl,
	write('| |_) | | | | (_| | | |_| | |  __/ | |       >  <     \\ V  V /  | | | | | | \\__ \\ |_|'), nl,
	write('| .__/  |_|  \\__,_|  \\__, |  \\___| |_|      /_/\\_\\     \\_/\\_/   |_| |_| |_| |___/ (_)'), nl,
	write('|_|                  |___/                                                           '), nl.

display_winner(en, 2) :-
	write('          _                                    ___                 _                 _ '), nl,
	write('  _ __   | |   __ _   _   _    ___   _ __     /   \\    __      __ (_)  _ __    ___  | |'), nl,
	write(' | \'_ \\  | |  / _` | | | | |  / _ \\ | \'__|   |     |   \\ \\ /\\ / / | | | \'_ \\  / __| | |'), nl,
	write(' | |_) | | | | (_| | | |_| | |  __/ | |      |     |    \\ V  V /  | | | | | | \\__ \\ |_|'), nl,
	write(' | .__/  |_|  \\__,_|  \\__, |  \\___| |_|       \\___/      \\_/\\_/   |_| |_| |_| |___/ (_)'), nl,
	write(' |_|                  |___/                                                                  '), nl.

% English is the default if there is no translation available
display_winner(_, Winner) :-
	display_winner(en, Winner).
