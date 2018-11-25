% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

partition(_, [], [], []).

partition(Pivot, [Head|Tail], [Head|LeftPart], RightPart):- 
	Pivot >= Head, partition(Pivot, Tail, LeftPart, RightPart).

partition(Pivot, [Head|Tail], LeftPart, [Head|RightPart]):- 
	partition(Pivot, Tail, LeftPart, RightPart).

qsort([], []).

qsort([Head|Tail], K):-
	partition(Head, Tail, LeftPart, RightPart),
	qsort(LeftPart, SortedLeftPart),
	qsort(RightPart, SortedRightPart),
	append(SortedLeftPart, [Head|SortedRightPart], K).

:- qsort([1, 2, 3, -4, 6, 7, 0, 3, 4, -1], R), write("R = "), writeln(R).
% R = [-4,-1,0,1,2,3,3,4,6,7]