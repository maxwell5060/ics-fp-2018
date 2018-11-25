% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 
-------------------------------Code Correction---------------------------------
qsort([],[]).
qsort([X|Xs],Ys) :-
  partition(Xs,X,Left,Right),
  qsort(Left,Ls),
  qsort(Right,Rs),
  append(Ls,[X|Rs],Ys).

partition([X|Xs],Y,[X|Ls],Rs) :- X =< Y, partition(Xs,Y,Ls,Rs).
partition([X|Xs],Y,Ls,[X|Rs]) :- X > Y, partition(Xs,Y,Ls,Rs).
partition([],Y,[],[]).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).


?- qsort([5,8,3,0,1,9,2,7], X).
X = [0, 1, 2, 3, 5, 7, 8, 9] 
