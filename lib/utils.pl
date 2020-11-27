:- use_module(library(lists)).
:- use_module(library(random)).

% -----------------------------------------------
% List functions
% -----------------------------------------------

% Calculates length of list
len([],0).
len([_|T],N) :-
	len(T,A),
	N is A + 1.

% Chooses a random element from a list.
% random_list(+List, -Element).
random_list(List, Element) :-
        len(List, X),
        random(0, X, R),
        nth0(R, List, Element).

% Sum of all elements in a list.
% sumList(+List, -Sum).
sumList([], 0).
sumList([X|L], Sum) :-
	sumList(L, NewSum),
	Sum is NewSum + X.
