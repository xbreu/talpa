:- consult('../utils.pl').
:- consult('../board/cells.pl').
:- consult('../text/input.pl').
:- consult('../variables.pl').

% -----------------------------------------------
% Read movement
% -----------------------------------------------

getMovement(Board, Player, Row, Column, Direction) :-
	indicatePlayerTurn(Player),
	getValidMovement(Board, Player, Row, Column, Direction).

getMovement_r(Board, Player, Row, Column) :-
	indicatePlayerTurn(Player),
	indicateToRemove,
	getValidMovement(Board, Player, Row, Column).

getValidMovement(Board, Player, Row, Column, Direction) :-
	getCell(Board, Player, RawRow, RawCol),
	getValidDirections(Board, Player, RawRow-RawCol, ListOfDirections),
	ListOfDirections \= [],
	getDirection(ListOfDirections, Direction),
	getRealInput(RawRow-RawCol, Row-Column).

getValidMovement(Board, Player, Row, Column, Direction) :-
	indicateNoMovementsFromPiece,
	getValidMovement(Board, Player, Row, Column, Direction).

getValidMovement(Board, Player, Row, Column) :-
	getCell(Board, Player, RawRow, RawCol),
	getRealInput(RawRow-RawCol, Row-Column).

getDirection(Valid, Direction) :-
	requestDirection,
	getCharOptions(Valid, Direction).

getDirection(Valid, Direction) :-
	indicateNotMember(Valid),
	requestAfterInvalid,
	getDirection(Valid, Direction).

validMove(Board, OppositePlayer, w, AuxRow-Col) :-
	Row is AuxRow - 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

validMove(Board, OppositePlayer, a, Row-AuxCol) :-
	Col is AuxCol - 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

validMove(Board, OppositePlayer, s, AuxRow-Col) :-
	Row is AuxRow + 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

validMove(Board, OppositePlayer, d, Row-AuxCol) :-
	Col is AuxCol + 1,
	getValueInMatrix(Board, Row, Col, OppositePlayer).

getValidDirections(Board, Player, Row-Col, List) :-
	swap_players(Player, OppositePlayer),
	getRealInput(Row-Col, RealRow-RealCol),
	findall(Direction, validMove(Board, OppositePlayer, Direction, RealRow-RealCol), List).

% -----------------------------------------------
% Read cell
% -----------------------------------------------

getCell(Board, Player, Row, Col) :-
	readRow(Row),
	readCol(Col),
	getRealInput(Row-Col, RealRow-RealCol),
	getValueInMatrix(Board, RealRow, RealCol, Player), !.

getCell(Board, Player, Row, Col) :-
	indicateInvalidPiece,
	getCell(Board, Player, Row, Col).

readRow(Row) :-
	numberOfLines(Max),
	requestRow,
	getIntInterval(1, Max, Row).

readCol(Result) :-
	numberOfCols(MaxCols),
	Code is MaxCols + 96,
	char_code(Max, Code),
	requestCol,
	getCharInterval('a', Max, Col),
	Result is Col - 96.

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
% Read Characters
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

% -----------------------------------------------
% Get real input
% -----------------------------------------------

getRealInput(Line-Col, RealLine-RealCol) :-
	getRealLine(Line, RealLine),
	getRealColumn(Col, RealCol).

getRealLine(Line, RealLine):-  
	numberOfLines(NumLines), 
	RealLine is NumLines - Line.

getRealColumn(Col, RealCol) :-
	RealCol is Col - 1.
