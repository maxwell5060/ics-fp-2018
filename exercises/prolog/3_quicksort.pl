% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort(Xs, Ys):- qsort1(Xs, Ys, []).
qsort1([], Ys, Ys).

qsort1([X|Xs], Ys, Zs):-
  partition(Xs, X, Left, Rigth),
  qsort1(Rigth, Ws, Zs),
  qsort1(Left, Ys, [X|Ws]).
  
partition([K|P], X, M, [K|N]):-
  X < K, !,
  partition(P, X, M, N).
  
partition([K|P], X, [K|M], N):-
  partition(P, X, M, N).
  
partition([], _, [], []).

% ?- qsort([1,8,2,4,7,0,9,6], Sort).
% Sort = [0, 1, 2, 4, 6, 7, 8, 9].