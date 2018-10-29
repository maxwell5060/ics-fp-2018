% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort(L, K):- q_sort(L, K).

q_sort([],[]).
q_sort([Lh|Lt], K):-
    pivot(Lh, Lt, Left, Right),
    q_sort(Left, Ll),
    q_sort(Right, Lr),
    append(Ll, [Lh|Lr], K).

pivot(Lh, [], [], []).
pivot(Lh, [H|Lt], [H|Left], Right):-
    H=<Lh, pivot(Lh, Lt, Left, Right).
pivot(Lh, [H|Lt], Left, [H|Right]):-
    H>Lh, pivot(Lh, Lt, Left, Right).