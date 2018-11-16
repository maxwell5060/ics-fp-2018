% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort([], []).
qsort([H|T], Res) :-
	quicksort(T, H, Left, Right),
	qsort(Left, RLeft),
	qsort(Right, RRight),
	append(RLeft, [H|RRight], Res).

quicksort([], _, [], []).
quicksort([H|T], Pivot, [H|Left], Right) :- 
    H =< Pivot,
    quicksort(T, Pivot, Left, Right),!.
quicksort([H|T], Pivot, Left, [H|Right]) :-
    H > Pivot,
    quicksort(T, Pivot, Left, Right).
