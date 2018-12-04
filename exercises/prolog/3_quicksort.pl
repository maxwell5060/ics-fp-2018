% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

qsort([], _).
qsort(L, K) :-
    L = [H|T],
    partition(H, T, Lp, Rp),
    qsort(Lp, Ls),
    qsort(Rp, Rs),
    append(Ls, [H|Rs], K).

partition(_, [], _, _).
partition(A, L, Lp, Rp) :-
    L = [H|T],
    Lp = [H|Tp],
    A >= H,
    partition(H, T, Tp, Rp).
partition(A, L, Lp, Rp) :-
    L = [H|T],
    Rp = [H|Tp],
    A < H,
    partition(H, T, Lp, Tp).
