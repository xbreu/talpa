:- consult('../variables.pl').
:- consult('../utils.pl').

% -----------------------------------------------
% Board matrix construction
% -----------------------------------------------

% returns a list with the columns starting with 'a' and following ascii sequence
columns([], 0).
columns(List, Len) :-
	Code is Len + 96,
	char_code(Head, Code),
	Len1 is Len - 1,
	columns(Tail, Len1),
	append(Tail, [Head], List).
columns(Length) :-
	columns([], Length).

% adds an element to each line with the respective number of the line in decrescent order
add_line_symbols([], _, []).
add_line_symbols([Head | Tail], Number, [[NumberEncoded | Head] | Recursion]) :-
	Number1 is Number + 1,
	numberOfLines(L),
	NumberEncoded is -(L - Number + 1),
	add_line_symbols(Tail, Number1, Recursion).
add_line_symbols([Head | Tail], [[0 | Head] | ResultMatrix]) :-
	add_line_symbols(Tail, 1, ResultMatrix).

% returns the board matrix
get_board_matrix(Board, BoardMatrix) :-
	numberOfCols(N),
	columns(ColumnList, N),
	append([ColumnList], Board, Matrix),
	add_line_symbols(Matrix, BoardMatrix).

print_board(Board) :-
	get_board_matrix(Board, Matrix),
	print_matrix(Matrix).

% -----------------------------------------------
%	Matrix
% -----------------------------------------------   

% Main function to print the matrix.
print_matrix([]).
print_matrix([H|T]) :-
	print_first_row(H),
	beginning_of_line,
	top_left_intersection,
    length(H, L),
    RealSize is L - 1,
    print_first_line(RealSize),
    print_middle_matrix(T).

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
	new_line.
print_row([H|T]) :-
	print_cell(H),
	vertical,
	print_row(T).

print_first_row([]) :-
	print_row([]).
print_first_row([H|T]) :-
	print_cell(H),
	write(' '),
	print_first_row(T).


print_middle_row(R) :-
    print_row(R),
   	beginning_of_line,
    left_intersection,
    length(R, L),
    RealSize is L - 1,
    print_middle_line(RealSize).

print_last_row(R) :-
    print_row(R),
   	beginning_of_line,
    bottom_left_intersection,
    length(R, L),
    RealSize is L - 1,
    print_last_line(RealSize).

% -----------------------------------------------
%	Lines
% -----------------------------------------------

beginning_of_line :-
	padding_size(X),
    X3 is X * 3,
    print_chars(X3, ' ').

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

print_cell(Number) :-
	number(Number),
	Number < 0, !,
	RealNumber is - Number,
	print_cell_content(RealNumber).
print_cell(H) :-
    code(H, C),
    print_cell_content(C).

print_cell_content(Content) :-
	padding,
	write(Content),
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
