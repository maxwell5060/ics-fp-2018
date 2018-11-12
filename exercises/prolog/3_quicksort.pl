% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

quicksort([H|T],X):-
	partition(H,T,Left,Right),
	quicksort(Left,S1),
	quicksort(Right,S2),
	append(S1,[H|S2],X).

quicksort([],[]).

partition(Pivot,[H|T],[H|Rest],RightSide):-
	H =< Pivot,
	partition(Pivot,T,Rest,RightSide).

partition(Pivot,[H|T],LeftSide,[H|Rest]):-
	H > Pivot,
	partition(Pivot,T,LeftSide,Rest).

partition(_,[],[],[]).