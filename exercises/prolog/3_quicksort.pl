

qsort([], []).


qsort([Elem], [Elem]).


qsort([Pivot|Tail], Sorted):-
  		divide(Tail, Pivot, BigP, SmallP),
  		qsort(BigP, SortedBigP),
  		qsort(SmallP, SortedSmallP),!,
  		append(SortedSmallP, [Pivot|SortedBigP], Sorted).


divide([], _, [], []):-!.


divide([Head|Tail], Pivot, [Head|BigP], SmallP):-
  	Head >= Pivot, !, divide(Tail, Pivot, BigP, SmallP).


divide([Head|Tail], Pivot, BigP, [Head|SmallP]):-
  	divide(Tail, Pivot, BigP, SmallP).


% ?- qsort([2,3,34, 5,1,10,1,3,6], K).
% K = [1, 1, 2, 3, 3, 5, 6, 10, 34].

