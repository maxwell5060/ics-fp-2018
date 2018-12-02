% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 
qsort([], []).
qsort([H|T], R) :- part(H, T, S, B),
                           qsort(S, L),
                           qsort(B, G),
                           append(L, [H|G], R).
 
part(H, [A|T], [A|S], B) :- A =< H, !,part(H, T, S, B).
part(H, [A|T], S, [A|B]) :- part(H, T, S, B).
part(_, [], [], []).
