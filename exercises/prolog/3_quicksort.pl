% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

part(_, [], [], []).
part(P, [H|T], [H|L], R) :- P > H, part(P, T, L, R).
part(P, [H|T], L, [H|R]) :- part(P, T, L, R).

qsort([], []).
qsort([H|T], S) :- part(H, T, L, R), qsort(L, SL), qsort(R, SR), append(SL, [H|SR], S).

:-
write("qsort([0,9,1,8,2,7,5,5,5], A): "),
qsort([0,9,1,8,2,7,5,5,5], A),
writeln(A),
writeln("").

% qsort([0,9,1,8,2,7,5,5,5], A): [0,1,2,5,5,5,7,8,9]
