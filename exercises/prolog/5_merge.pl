% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

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

mrg(L1, L2, R) :-
append(L1, L2, L12),
qsort(L12, R).

:- forall(mrg([1,2,4,5,18],[1,3,5,10],L), write(L)), nl.

:- halt.
