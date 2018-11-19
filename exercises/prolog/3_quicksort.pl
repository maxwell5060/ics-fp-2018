% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированны

qsort([],[]).
qsort([X|Xs],Ys) :-
partition(Xs,X,Left,Right),
qsort(Left,Ls),
qsort(Right,Rs),
append(Ls,[X|Rs],Ys).

partition([X|Xs],Y,[X|Ls],Rs):- X =< Y, partition(Xs,Y,Ls,Rs).
partition([X|Xs],Y,Ls,[X|Rs]):- X > Y, partition(Xs,Y,Ls,Rs).
partition([],_,[],[]).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).

:- write('Unsorted:'), nl.
:- write('[5, -9, -22, 54, 6, 8, 1, 4]'), nl.
:- write('Sorted:'), nl.
:- forall(qsort([5, -9, -22, 54, 6, 8, 1, 4], Sd), write(Sd)).

:- halt.
