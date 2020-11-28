:- consult('ask.pl').
:- consult('../utils/utils.pl').
:- consult('../variables.pl').
:- consult('../board/cells.pl').

% -----------------------------------------------
% Read movement
% -----------------------------------------------

getRemoveMovement(Board, Player, Row, Column) :-
	indicatePlayerTurn(Player),
	indicateToRemove,
	getCell(Board, Player, Row, Column).

getMovement(Board, Player, Row, Column, Direction) :-
	indicatePlayerTurn(Player),
	getValidMovement(Board, Player, Row, Column, Direction).

getValidMovement(Board, Player, Row, Column, Direction) :-
	getCell(Board, Player, Row, Column),
	getValidDirections(Board, Player, Row-Column, ListOfDirections),
	getDirection(ListOfDirections, Direction).

getValidMovement(Board, Player, Row, Column, Direction) :-
	indicateNoMovementsFromPiece,
	getValidMovement(Board, Player, Row, Column, Direction).

% -----------------------------------------------
% Read direction
% -----------------------------------------------

getDirection(Valid, Direction) :-
	requestDirection,
	getCharOptions(Valid, Direction).

getDirection(Valid, Direction) :-
	indicateNotMember(Valid),
	requestAfterInvalid,
	getDirection(Valid, Direction).

getValidDirections(Board, Player, Row-Col, List) :-
	swap_players(Player, OppositePlayer),
	findall(Direction, validDirection(Board, OppositePlayer, Direction, Row-Col), List),
	List \= [].

validDirection(Board, OppositePlayer, w, AuxRow-Col) :-
	Row is AuxRow - 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

validDirection(Board, OppositePlayer, a, Row-AuxCol) :-
	Col is AuxCol - 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

validDirection(Board, OppositePlayer, s, AuxRow-Col) :-
	Row is AuxRow + 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

validDirection(Board, OppositePlayer, d, Row-AuxCol) :-
	Col is AuxCol + 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

% -----------------------------------------------
% Read cell
% -----------------------------------------------

getCell(Board, Player, Row, Col) :-
	readRow(Row),
	readCol(Col),
	getValueInMatrix(Board, Row, Col, Player), !.

getCell(Board, Player, Row, Col) :-
	indicateInvalidPiece,
	getCell(Board, Player, Row, Col).

readRow(Result) :-
	numberOfLines(Max),
	requestRow,
	getIntInterval(1, Max, Row),
	numberOfLines(NumLines),
    Result is NumLines - Row.

readCol(Result) :-
	numberOfCols(MaxCols),
	Code is MaxCols + 96,
	char_code(Max, Code),
	requestCol,
	getCharInterval('a', Max, Col),
	Result is Col - 97.

% -----------------------------------------------
% Read values
% -----------------------------------------------

getIntInterval(Min, Max, Value) :-
	readDigit(Value),
	between(Min, Max, Value), !.

getIntInterval(Min, Max, Value) :-
	indicateInvalidDomain(Min, Max),
	requestAfterInvalid,
	getIntInterval(Min, Max, Value).

getCharInterval(Min, Max, CharValue) :-
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
% Read characters
% -----------------------------------------------

readDigit(Value) :-
	readChar(ValueChar),
	charToInt(ValueChar, Value).

readChar(Char) :-
	get_char(Char),
    skip_line.

charToInt(Char, Value) :-
	char_code(Char, ValueASCII),
    Value is ValueASCII - 48.
