% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный
partition(P, [H|T], [H|Less], Greater) :- H =< P, partition(P, T, Less, Greater).
partition(P, [H|T], Less, [H|Greater]) :- H > P, partition(P, T, Less, Greater).
partition(_, [], [], []).

qsort([H|T], Sorted) :- partition(H, T, Less, Greater), qsort(Less, SortedLess), qsort(Greater, SortedGreater), append(SortedLess, [H|SortedGreater], Sorted).
qsort([], []).

% qsort([4, 3, 7, 6, 1, 2, 9, 8, 5], X).
% X = [1, 2, 3, 4, 5, 6, 7, 8, 9]