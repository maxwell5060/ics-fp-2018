% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

partition([E|Elist],Y,[E|Hlist],Tlist) :-
  E =< Y, partition(Elist,Y,Hlist,Tlist).
partition([E|Elist],Y,Hlist,[E|Tlist]) :-
  E > Y, partition(Elist,Y,Hlist,Tlist).
partition([], _,[],[]).

qsort([],[]).
qsort([E|Elist], K) :-
  partition(Elist, E, Head, Tail),
  qsort(Head, Hlist),
  qsort(Tail, Tlist),
  append(Hlist, [E|Tlist], K).