% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
    :- include('3_quicksort.pl').

    b_split(List, Left, Right) :- append(Left, Right, List),
    length(Left, LeftLength),
    length(Right, RightLength),
    (LeftLength =:= RightLength; LeftLength =:= (RightLength - 1)), !.

    balanced_tree([], empty).

    balanced_tree(List, instant(Root, empty, empty)) :-
    List = [Root|[]], !.

    balanced_tree([Root1|[Root2|[]]], instant(Root2, LeftLeaf, empty)) :-
    Root1 < Root2,
    balanced_tree([Root1], LeftLeaf), !.

    balanced_tree([Root2|[Root1|[]]], instant(Root2, LeftLeaf, empty)) :-
    balanced_tree([Root1], LeftLeaf), !.

    balanced_tree(List, instant(Mid, LeftLeaf, RightLeaf)) :-
    qsort(List, Sorted),
    b_split(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LeftLeaf),
    balanced_tree(RightList, RightLeaf), !.
