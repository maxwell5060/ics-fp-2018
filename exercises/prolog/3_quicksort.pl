% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный
    qsort(L, K) :- effective_qsort(L, K).

    make_pivot(_, [], [], []).
    make_pivot(H, [X|T], [X|L], G):- X =< H, make_pivot(H, T, L, G).
    make_pivot(H, [X|T], L, [X|G]):-  X > H, make_pivot(H, T, L, G).

    effective_qsort(L, S) :- effective_qsort_impl(L, [], S).
    effective_qsort_impl([], A, A).
    effective_qsort_impl([H|T], A, S):- make_pivot(H, T, L1, L2), effective_qsort_impl(L1, A, S1), effective_qsort_impl(L2, [H|S1], S).
