% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный
qsort(L,K):-
		L = [Head|Tail],
		partition(Head, Tail, List1, List2),
		qsort(List1, Sorted1),
		qsort(List2, Sorted2),
		append(Sorted1, [Head|Sorted2], K).

qsort([], []).

partition(Current, [Head|Tail], [Head|LowEq], High):-
		Current >= Head,
		partition(Current, Tail, LowEq, High).

partition(Current, [Head|Tail], LowEq, [Head|High]):-
		partition(Current, Tail, LowEq, High).

partition(_, [], [], []).

run:-
	List = [-69, 86, 23, -95, 76, -37, 28, -41, 76, 11, 2, -83, 8, 61, 21, -17, -61, -25, -45, 80, 39],
	qsort(List, Sorted),
	write(Sorted).

% ?- run.
% [-95,-83,-69,-61,-45,-41,-37,-25,-17,2,8,11,21,23,28,39,61,76,76,80,86]
% true 