% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный


qsort([], []).
qsort(L, K) :-
    L = [H|T],
    partition(H, T, Lp, Rp),
    qsort(Lp, Ls),
    qsort(Rp, Rs),
    append(Ls, [H|Rs], K).

partition(_, [], [], []).
partition(A, L, Lp, Rp) :-
    L = [H|T],
    Lp = [H|Tp],
    A >= H,
    partition(A, T, Tp, Rp).
partition(A, L, Lp, Rp) :-
    L = [H|T],
    Rp = [H|Tp],
    A < H,
    partition(A, T, Lp, Tp).
