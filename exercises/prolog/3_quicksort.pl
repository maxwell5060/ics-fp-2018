% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

pivot(_, [], [], []).

pivot(Pivot, [Head|Tail], [Head|Left], Right) :- Pivot >= Head, pivot(Pivot, Tail, Left, Right).
pivot(Pivot, [Head|Tail], Left, [Head|Right]) :- pivot(Pivot, Tail, Left, Right).

qsort(L, K) :- quicksort(L, K).
quicksort([], []).
quicksort([Head|Tail], Sorted) :-
pivot(Head, Tail, List1, List2),
quicksort(List1, SortedList1),
quicksort(List2, SortedList2),
append(SortedList1, [Head|SortedList2],
Sorted).
