:- consult('../board/cells.pl').
:- consult('../text/input.pl').
:- consult('../variables.pl').

% -----------------------------------------------
% Read movement
% -----------------------------------------------

getMovement(Board, Player, Row, Column, Direction) :-
	indicatePlayerTurn(Player),
	getCell(Board, Player, RawRow, RawCol),
	getDirection([w, a, s, d], Direction),
	getRealInput(RawRow, RawCol, Row, Column).

getMovement_r(Board, Player, Row, Column) :-
	indicatePlayerTurn(Player),
	indicateToRemove,
	getCell(Board, Player, RawRow, RawCol),
	getRealInput(RawRow, RawCol, Row, Column).
getDirection(Valid, Direction) :-
	requestDirection,
	getCharOptions(Valid, Direction).

getDirection(Valid, Direction) :-
	indicateNotMember(Valid),
	requestAfterInvalid,
	getDirection(Valid, Direction).

% -----------------------------------------------
% Read cell
% -----------------------------------------------

readRow(Row) :-
	numberOfLines(Max),
	requestRow,
	getIntInterval(1, Max, Row).

readCol(Col) :-
	numberOfCols(MaxCols),
	Code is MaxCols + 96,
	char_code(Max, Code),
	requestCol,
	getCharInterval('a', Max, Col).

getCell(Board, Player, Row, Col) :-
	readRow(Row),
	readCol(Col),
	getValueInMatrix(Board, Row, Col, Player), !.

getCell(Board, Player, Row, Col) :-
	indicateInvalidPiece,
	requestAfterInvalid,
	getCell(Board, Player, Row, Col).

% -----------------------------------------------
% Read Values
% -----------------------------------------------

getIntInterval(Min, Max, Value) :-
	readDigit(Value),
	between(Min, Max, Value), !.

getIntInterval(Min, Max, Value) :-
	indicateInvalidDomain(Min, Max),
	requestAfterInvalid,
	getIntInterval(Min, Max, Value).

getCharInterval(Min, Max, Value) :-
	readChar(Value),
	char_code(Value, CharValue),
	char_code(Min, MinValue),
	char_code(Max, MaxValue),
	between(MinValue, MaxValue, CharValue), !.

getCharInterval(Min, Max, Value) :-
	indicateInvalidDomain(Min, Max),
	requestAfterInvalid,
	getCharInterval(Min, Max, Value).

getCharOptions(Options, Value) :-
	readChar(Value),
	member(Value, Options), !.

getCharOptions(Options, Value) :-
	indicateNotMember(Options),
	requestAfterInvalid,
	getCharOptions(Options, Value).

% -----------------------------------------------
% Read Characters
% -----------------------------------------------

readChar(Char) :-
	get_char(Char),
    skip_line.

readDigit(Value) :-
	readChar(ValueChar),
	charToInt(ValueChar, Value).

charToInt(Char, Value) :-
	char_code(Char, ValueASCII),
    Value is ValueASCII - 48.

% -----------------------------------------------
% Get real input
% -----------------------------------------------

getRealInput(Line, Col, RealLine, RealCol):-
	getRealLine(Line, RealLine), 
	getRealCol(Col, RealCol).

getRealLine(Line, RealLine):-  
	numberOfLines(NumLines), 
	RealLine is NumLines - Line. 

getRealCol(Col, RealCol):-
	char_code(Col, X),    
	RealCol is X - 97.
