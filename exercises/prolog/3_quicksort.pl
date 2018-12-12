% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

less(A, B) :- A < B.
more(A, B) :- A >= B.

split(E, A, L, R) :- exclude(less(E), A, L), exclude(more(E), A, R).

qsort([H | T], R) :- split(H, T, Left, Right), qsort(Left, NewLeft), qsort(Right, NewRight), append(NewLeft, [H | NewRight], R).
qsort([], []).
