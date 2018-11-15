% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 
%qsort(L, R)
qsort([], []).
qsort([H|T], R) :- partition(T, H, SM, GR), qsort(SM, R1), qsort(GR, R2), appened(R1, [H|R2], R).

%partition(L, P, SM, GR)
partition([], _, [], []).
partition([H|T], P, [H|TSM], GR) :- H =< P, partition(T, P, TSM, GR).
partition([H|T], P, SM, [H|TGR]) :- H > P, partition(T, P, SM, TGR).

%appened(L1, L2, R)
appened([], L2, L2).
appened([H|T1], L2, [H|TR]) :- appened(T1, L2, TR).