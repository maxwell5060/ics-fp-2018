% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

partition_by_pivot(_, [], [], []).

partition_by_pivot(Pivot, [Head|Tail], [Head|Left], Right) :-
    Pivot >= Head,
    partition_by_pivot(Pivot, Tail, Left, Right), !.

partition_by_pivot(Pivot, [Head|Tail], Left, [Head|Right]) :-
    partition_by_pivot(Pivot, Tail, Left, Right).

qsort([], []).

qsort([Head|Tail], Sorted) :-
    partition_by_pivot(Head, Tail, Left, Right),
    qsort(Left, LeftSorted),
    qsort(Right, RightSorted),
    append(LeftSorted, [Head|RightSorted], Sorted).


% Test

:- initialization
    qsort([2, 7, 8, 5, 3, 1, 9, 6, 4, 0], S),
    writeln(S),
    halt.
