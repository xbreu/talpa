% -----------------------------------------------
%  Options
% -----------------------------------------------
requestOption(Min, Max) :-
	format('Choose an option [~d-~d] >>', Min, Max).

requestLevel :-
	write('Choose a level [1-9] or type 0 >>').
