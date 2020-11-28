:- consult('translations.pl').
:- consult('../variables.pl').

prompt :-
	write(' >> ').

indicationBefore :-
	write('> ').
indicationAfter :-
	write(' <'), nl.

requestRow :-
	language(Language),
	requestInputRowString(Language, RowString),
	write(RowString),
	prompt.

requestCol :-
	language(Language),
	requestInputColString(Language, ColString),
	write(ColString),
	prompt.

requestDirection :-
	language(Language),
	requestInputDirString(Language, DirString),
	write(DirString),
	write(' [wasd]'),
	prompt.

requestAfterInvalid :-
	language(Language),
	requestTryAgainString(Language, TryAgainString),
	write(TryAgainString),
	prompt.

requestOption(Min, Max) :-
	language(Language),
	requestIntervalOptionString(Language, OptionString),
	format(OptionString, [Min, Max]),
	prompt.

requestLevel(Min, Max) :-
	language(Language),
	requestLevelOptionString(Language, LevelString),
	format(LevelString, [Min, Max]),
	prompt.

indicatePlayerTurn(Player) :-
	code(Player, Code),
	language(Language),
	indicatePlayerTurnString(Language, TurnString),
	indicationBefore,
	format(TurnString, [Code]),
	indicationAfter.

indicateToRemove :-
	language(Language),
	indicateNoMovesString(Language, RemoveString),
	indicationBefore,
	write(RemoveString),
	indicationAfter.

indicateInvalidDomain(Min, Max) :-
	language(Language),
    indicateInvalidDomainString(Language, String),
    indicationBefore,
    format(String, [Min, Max]),
    indicationAfter.

indicateNotMember(Options) :-
	language(Language),
    indicateNotMemberString(Language, String),
    indicationBefore,
    format(String, [Options]),
    indicationAfter.

indicateNoMovementsFromPiece :-
	language(Language),
    indicateNoMovementsFromPieceString(Language, String),
    indicationBefore,
    write(String),
    indicationAfter.

indicateInvalidPiece :-
	language(Language),
	indicateInvalidPieceString(Language, PieceString),
	indicationBefore,
	write(PieceString),
	indicationAfter.