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
