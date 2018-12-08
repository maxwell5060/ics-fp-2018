% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort([],[]).
qsort([Head|Tail],Result) :-
	partition(Head,Tail,Left,Right),
	qsort(Left,SortedLeft),
	qsort(Right,SortedRight),
	append(SortedLeft,[Head|SortedRight],Result).

partition(_,[],[],[]).
partition(Pivot,[Head|Tail],[Head|Left],Right) :-
	Pivot > Head, partition(Pivot,Tail,Left,Right).
partition(Pivot,[Head|Tail],Left,[Head|Right]) :-
	partition(Pivot,Tail,Left,Right).

% ?- qsort([4,-66,-95,-6,6,53,-60,47,-51],Result).
% Result = [-95, -66, -60, -51, -6, 4, 6, 47, 53]