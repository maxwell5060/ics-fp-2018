% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

fork([], _, [], []).
fork([X| Xs], Pivot, Smalls, Bigs) :-
    (    X =< Pivot ->
         Smalls = [X|Rest],
         fork(Xs, Pivot, Rest, Bigs);
         Bigs = [X|Rest],
         fork(Xs, Pivot, Smalls, Rest)).
qsort([], []).
qsort([X|Xs], R):-
    fork(Xs, X, Smaller0, Bigger0),
    qsort(Smaller0, Smaller),
    qsort(Bigger0, Bigger),
    append(Smaller, [X|Bigger], R).

% RESULT:  ?- qsort([1,2,-4,0], L).
%           L = [-4, 0, 1, 2].