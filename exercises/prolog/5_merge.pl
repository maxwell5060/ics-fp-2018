% определить предикат mrg(L1, L2, L) который для двух отсортированных списков L1 и L2
% определяет список L, составленный из этих элементов

merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(List,Sorted):-
    List=[_,_|_],divide(List,L1,L2),
	merge_sort(L1,Sorted1),merge_sort(L2,Sorted2),
	merge(Sorted1,Sorted2,Sorted).

merge([],L,L).
merge(L,[],L):-L\=[].
merge([X|T1],[Y|T2],[X|T]):-X=<Y,merge(T1,[Y|T2],T).
merge([X|T1],[Y|T2],[Y|T]):-X>Y,merge([X|T1],T2,T).

% ?- merge([1,1,6,7],[1,2,3,6,7],L).
% L = [1, 1, 1, 2, 3, 6, 6, 7, 7] ;
