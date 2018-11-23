% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort(L, K) :-
  L = [Head|Tail],
  pivot(Head,Tail,Left,Right),
  qsort(Left,LeftSorted),
  qsort(Right,RightSorted),
  append(LeftSorted,[Head|RightSorted],K).
qsort([],[]).

pivot(X,[Head|Tail],[Head|Ls],Rs) :- 
  X > Head, pivot(X,Tail,Ls,Rs).
pivot(X,[Head|Tail],Ls,[Head|Rs]) :- 
  pivot(X,Tail,Ls,Rs).
pivot(_,[],[],[]).


/* Example of usage

?- qsort([5,0,11,13,12,-2,0,59,2],R).
R = [-2, 0, 0, 2, 5, 11, 12, 13, 59]
*/
