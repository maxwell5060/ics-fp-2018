% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

pivot(_, [], [], []).
pivot(Pivot, [Head|Tail], [Head|LessOrEqualThan], GreaterThan) :-
    Pivot >= Head, pivot(Pivot, Tail, LessOrEqualThan, GreaterThan).
pivot(Pivot, [Head|Tail], LessOrEqualThan, [Head|GreaterThan]) :-
    pivot(Pivot, Tail, LessOrEqualThan, GreaterThan).

qsort([], []).
qsort([Head|Tail], Sorted) :-
    pivot(Head, Tail, List1, List2),
    qsort(List1, SortedList1),
    qsort(List2, SortedList2),
    append(SortedList1, [Head|SortedList2], Sorted).

%?- qsort([2,1,3,19],K).
%K = [1, 2, 3, 19] 