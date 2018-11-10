% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% Quicksort

partition_by_pivot(_, [], [], []).

partition_by_pivot(Pivot, [Head|Tail], [Head|Left], Right) :-
    Pivot >= Head,
    partition_by_pivot(Pivot, Tail, Left, Right), !.

partition_by_pivot(Pivot, [Head|Tail], Left, [Head|Right]) :-
    partition_by_pivot(Pivot, Tail, Left, Right).

qsort([], []).

qsort([Head|Tail], Sorted) :-
    partition_by_pivot(Head, Tail, Left, Right),
    qsort(Left, LeftSorted),
    qsort(Right, RightSorted),
    append(LeftSorted, [Head|RightSorted], Sorted).

% Split list by center helper function
split_by_center(List, Left, Right) :-
    append(Left, Right, List),
    length(Left, LeftLength),
    length(Right, RightLength),
    (LeftLength =:= RightLength; LeftLength =:= (RightLength - 1)), !.

% Balanced tree for an empty list
balanced_tree([], empty).

% Balanced tree for a single-element list
balanced_tree(List, instant(Head, empty, empty)) :-
    List = [Head|[]], !.

% Balanced tree for a two-element list (two versions, without sorting)
% When the first element less than the second
balanced_tree([Lo|[Hi|[]]], instant(Hi, LeftChild, empty)) :-
    Lo < Hi,
    balanced_tree([Lo], LeftChild), !.

% When the first element greater than the second
balanced_tree([Hi|[Lo|[]]], instant(Hi, LeftChild, empty)) :-
    balanced_tree([Lo], LeftChild), !.

% Balanced tree for a list of arbitrary size
balanced_tree(List, instant(Mid, LeftChild, RightChild)) :-
    qsort(List, Sorted),
    split_by_center(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LeftChild),
    balanced_tree(RightList, RightChild), !.

% Test:
% ?- balanced_tree([5,3,6,2,1,7,4], T).
% Output:
% T = instant(4, instant(2, instant(1, empty, empty), instant(3, empty, empty)), instant(6, instant(5, empty, empty), instant(7, empty, empty))).
