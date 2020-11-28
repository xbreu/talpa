:- use_module(library(lists)).
:- use_module(library(random)).

% -----------------------------------------------
% List functions
% -----------------------------------------------.

% Chooses a random element from a list.
% random_list(+List, -Element).
random_list(List, Element) :-
        length(List, X),
        random(0, X, R),
        nth0(R, List, Element).

swap_players(Player, OtherPlayer) :-
	OtherPlayer is Player mod 2 + 1.

clear(0) :- !.
clear(N) :-
	nl,
	N1 is N - 1,
	clear(N1).
clear :-
	clear(100).

ocurrenceOf([] , _,0).
ocurrenceOf([Element | Tail], Element, NewCount) :-
	ocurrenceOf(Tail, Element ,OldCount),
	NewCount is OldCount + 1.
ocurrenceOf([Head | Tail], Element, Count) :-
	dif(Head, Element),
	ocurrenceOf(Tail, Element, Count).
