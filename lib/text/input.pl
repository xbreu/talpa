% -----------------------------------------------
%  Move input
% -----------------------------------------------
requestInputRow :-
	write('ROW >>').

requestInputCol :-
	write('COL >>').

requestInputDir :-
	write('MOVE[wasd] >>').

% -----------------------------------------------
%  Information
% -----------------------------------------------
indicatePlayerTurn(Code) :-
	format('--Player ~s turn--', Code), nl.

indicateInvalidPiece :-
	write('That piece is not yours!'), nl.

indicateNoMoves :-
	write('No captures available. Remove a piece'), nl.

indicateInvalidInput() :-
	write('Invalid input!!'), nl.

indicateInvalidInput(Min, Max) :-
	format('>Invalid input. Range must be [~d-~d].<', Min, Max), nl.