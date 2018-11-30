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


balanced_tree([], empty).


balanced_tree(List, instant(Head, empty, empty)) :-
    List = [Head|[]], !.


balanced_tree([Lo|[Hi|[]]], instant(Hi, LeftChild, empty)) :-
    Lo < Hi,
    balanced_tree([Lo], LeftChild), !.


balanced_tree([Hi|[Lo|[]]], instant(Hi, LeftChild, empty)) :-
    balanced_tree([Lo], LeftChild), !.


balanced_tree(List, instant(Mid, LeftChild, RightChild)) :-
    qsort(List, Sorted),
    split_by_center(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LeftChild),
    balanced_tree(RightList, RightChild), !.

split_by_center(List, Left, Right) :-
    append(Left, Right, List),
    length(Left, LeftLength),
    length(Right, RightLength),
    (LeftLength =:= RightLength; LeftLength =:= (RightLength - 1)), !.


% balanced_tree([9,4,5,6,1,2,3,8], T).
% instant(5, instant(3, instant(2, instant(1, empty, empty), empty), instant(4, empty, empty)), instant(8, instant(6, empty, empty), instant(9, empty, empty))).


