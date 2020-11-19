:- consult('singleton.pl').
:- consult('utils.pl').

columns([], 0).

columns(List, Len) :-
	Code is Len + 96,
	char_code(Head, Code),
	Len1 is Len - 1,
	columns(Tail, Len1),
	append(Tail, [Head], List).

columns(Length) :-
	columns([], Length).

get_board_matrix(Board, Matrix) :-
	numberOfCols(N),
	columns(ColumnList, N),
	append([ColumnList], Board, Matrix).

print_board(Board) :-
	get_board_matrix(Board, Matrix),
	print_matrix(Matrix).

% -----------------------------------------------
%	Matrix
% -----------------------------------------------   

% Main function to print the matrix.
print_matrix([]).
print_matrix([H|T]) :-
	top_left_intersection,
    len(H, L),
    print_first_line(L),
    print_middle_matrix([H|T]).

% Function that prints the matrix of the game except for the first row.
print_middle_matrix([H|[]]) :- !,
    print_last_row(H).
print_middle_matrix([H|T]) :-
	print_middle_row(H),
	print_middle_matrix(T). 

% -----------------------------------------------
%	Rows
% ----------------------------------------------- 

print_row([]) :-
	vertical,
	new_line.
print_row([H|T]) :-
	vertical,
	code(H,C),
	print_cell(C),
	print_row(T).

print_middle_row(R) :-
    print_row(R),
    left_intersection,
    len(R, L),
    print_middle_line(L).

print_last_row(R) :-
    print_row(R),
    bottom_left_intersection,
    len(R, L),
    print_last_line(L).

% -----------------------------------------------
%	Lines
% -----------------------------------------------

print_first_line(1) :- !,
	print_horizontal,
	top_right_intersection,
	new_line.
print_first_line(X) :-
	print_horizontal,
	top_intersection,
	X1 is X - 1,
	print_first_line(X1).

print_middle_line(1) :- !,
	print_horizontal,
	right_intersection,
	new_line.
print_middle_line(X) :-
	print_horizontal,
	intersection,
	X1 is X - 1,
	print_middle_line(X1).

print_last_line(1) :- !,
	print_horizontal,
	bottom_right_intersection,
	new_line.
print_last_line(X) :-
	print_horizontal,
	bottom_intersection,
	X1 is X - 1,
	print_last_line(X1).

% -----------------------------------------------
%	Cells
% -----------------------------------------------

print_cell(C) :-
    padding,
    write(C),
    padding.

% -----------------------------------------------
%	Padding
% -----------------------------------------------

print_chars(0, _) :- !.
print_chars(N, C) :-
	write(C),
	M is N - 1,
	print_chars(M, C).

padding :-
	padding_size(N),
	print_chars(N, ' ').

print_horizontal :-
	padding_size(P),
	N is 2 * P + 1,
	print_chars(N, '\x2500\').

% -----------------------------------------------
%	Characters
% -----------------------------------------------

vertical :-
	write('\x2502\').

new_line :-
	write('\n').

intersection :-
	write('\x253C\').

right_intersection :-
	write('\x2524\').

left_intersection :-
	write('\x251C\').

top_intersection :-
	write('\x252C\').

bottom_intersection :-
	write('\x2534\').

top_right_intersection :-
	write('\x2510\').

top_left_intersection :-
	write('\x250C\').

bottom_right_intersection :-
	write('\x2518\').

bottom_left_intersection :-
	write('\x2514\').
