:- consult('singleton.pl').
padding_size(1).

% -----------------------------------------------
%	Matrix
% -----------------------------------------------   

/**
 Main function to print the matrix. 
*/ 
print_matrix([]).
print_matrix([H|T]) :-
	top_left_intersection,
    len(H, L),
    S is L + 1,
    print_first_line(S),
    vertical,
    print_columns(S),
    print_middle_matrix([H|T]).

 
/**
 Print the column names (e.g a,b,c,...) of the first row.  

 print_columns(+N, -S). 
 +N: Number of cells that are still to be processed. 
 -S: Current cell number.  
 */ 
print_columns(0, S) :- !,
	new_line,
    left_intersection,
    print_middle_line(S). 

print_columns(N, 0) :- !,
    print_cell(' '),
    vertical,
    N1 is N - 1,
    print_columns(N1, 1). 

print_columns(N, S) :-
	Code is S + 96,
	char_code(C, Code),
    print_cell(C),
    vertical,
    N1 is N - 1,
    S1 is S + 1,
    print_columns(N1, S1). 

print_columns(N) :-
	print_columns(N, 0).


/**
 * Function that prints the matrix of the game except for the first row.  
 */ 
print_middle_matrix([H|[]]) :- !,
	vertical,
    print_cell(1),
    print_last_row(H). 

print_middle_matrix([H|T]) :-
	vertical,
	len(T, L),
	S is L + 1,
    print_cell(S),
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
    S is L + 1,
    print_middle_line(S).

print_last_row(R) :-
    print_row(R),
    bottom_left_intersection,
    len(R, L),
    S is L + 1,
    print_last_line(S).

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
	X1 is X-1,
	print_first_line(X1).

print_middle_line(1) :- !,
	print_horizontal,
	right_intersection,
	new_line. 

print_middle_line(X) :-
	print_horizontal,
	intersection,
	X1 is X-1,
	print_middle_line(X1).

print_last_line(1) :- !,
	print_horizontal,
	bottom_right_intersection,
	new_line.
print_last_line(X) :-
	print_horizontal,
	bottom_intersection,
	X1 is X-1,
	print_last_line(X1).

% -----------------------------------------------
%	Cells
% -----------------------------------------------
print_cell(C) :-
	number(C),
	C > 9, !,
	padding,
	Code is C + 55,
	char_code(Char,Code),
	write(Char),
	padding.
print_cell(C) :-
    padding,
    write(C),
    padding.

% -----------------------------------------------
%	Auxiliary Functions
% -----------------------------------------------
len([],0).
len([_|T],N) :-
	len(T,A),
	N is A + 1.

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
