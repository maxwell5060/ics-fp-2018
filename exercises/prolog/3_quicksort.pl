% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort([], []).


qsort([Element], [Element]).


qsort([Piv|Tail], Sort):-
  		divide(Tail, Piv, BigP, SmallP),
  		qsort(BigP, SortBigP),
  		qsort(SmallP, SortSmallP),!,
  		append(SortSmallP, [Piv|SortBigP], Sort).


divide([], _, [], []):-!.


divide([Head|Tail], Piv, [Head|BigP], SmallP):-
  	Head >= Piv, !, divide(Tail, Piv, BigP, SmallP).


divide([Head|Tail], Piv, BigP, [Head|SmallP]):-
  	divide(Tail, Piv, BigP, SmallP).


% ?- qsort([7,9,34,1,27,11,4,88,23], K).
% K = [1,4,7,9,11,23,27,34,88].

