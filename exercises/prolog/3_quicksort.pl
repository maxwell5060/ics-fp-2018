% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

divide(_, [], [], []).

divide(Sep, [Head|Tail], [Head|Left], Right):-
	Sep >= Head,
	divide(Sep, Tail, Left, Right).

divide(Sep, [Head|Tail], Left, [Head|Right]):-
	divide(Sep, Tail, Left, Right).


qsort([], []).
qsort(L, K):-
	L = [Head|Tail],
	divide(Head, Tail, Left, Right),
	qsort(Left, SLeft),
	qsort(Right, SRight),
	append(SLeft, [Head|SRight], K).


/*

Results:

?- qsort([3,2,-10,4,5,9,3,1],R).
R = [-10, 1, 2, 3, 3, 4, 5, 9]

*/