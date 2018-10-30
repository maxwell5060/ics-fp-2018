% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

qsort(L, K) :- qsort2(L, K).
qsort2([],[]).
qsort2([H|L], K) :-
    partition(H, L, Small, Big),
    qsort2(Small, SortedSmall),
    qsort2(Big, SortedBig),
    append(SortedSmall, [H|SortedBig], K).

partition(_, [], [], []).
partition(X, [H|L], [H|Small], Big) :- X > H, partition(X, L, Small, Big).
partition(X, [H|L], Small, [H|Big]) :- partition(X, L, Small, Big).

% Example
% ?- qsort([4,7,1,89,42,3,12,21],K).
% K = [1, 3, 4, 7, 12, 21, 42, 89].
