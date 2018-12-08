% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 


qsort([],[]).
qsort([Head|Tail],Sorted) :-
	partition(Head,Tail,Smaller,Bigger),
	qsort(Smaller,SortedSmaller),
	qsort(Bigger,SortedBigger),
	append(SortedSmaller,[Head|SortedBigger],Sorted).
partition(_,[],[],[]).
partition(Pivot,[Head|Tail], [Head|Smaller], Bigger) :-
	Head =< Pivot, partition(Pivot,Tail,Smaller,Bigger).
partition(Pivot,[Head|Tail], Smaller, [Head|Bigger]) :-
	partition(Pivot,Tail,Smaller,Bigger).

%?- qsort([22,4,56,2,8,11],Sorted).
%Sorted = [2, 4, 8, 11, 22, 56] 
