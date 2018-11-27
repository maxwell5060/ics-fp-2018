% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

partition(_, [], [], []).

partition(Pivot, [Head|Tail], [Head|LeftPart], RightPart):- 
	Pivot >= Head, partition(Pivot, Tail, LeftPart, RightPart).

partition(Pivot, [Head|Tail], LeftPart, [Head|RightPart]):- 
	partition(Pivot, Tail, LeftPart, RightPart).

qsort([], []).

qsort([Head|Tail], K):-
	partition(Head, Tail, LeftPart, RightPart),
	qsort(LeftPart, SortedLeftPart),
	qsort(RightPart, SortedRightPart),
	append(SortedLeftPart, [Head|SortedRightPart], K).

split(List, LeftSplit, RightSplit) :-
	length(List, Length),
	Half is Length - Length // 2,
	length(RightSplit, Half),
	append(LeftSplit, RightSplit, List).

balanced_tree_no_sort([], empty).

balanced_tree_no_sort([Head|[]], instant(Head, empty, empty)).

balanced_tree_no_sort([Elem1|[Elem2|[]]], instant(Root, LeftSubTree, empty)) :-
    Elem1 < Elem2, Root = Elem2, balanced_tree([Elem1], LeftSubTree), !.

balanced_tree_no_sort([Elem1|[Elem2|[]]], instant(Root, LeftSubTree, empty)) :-
	Root = Elem1, balanced_tree([Elem2], LeftSubTree), !.

balanced_tree_no_sort([Head|Tail], instant(MiddleElem, LeftSubTree, RightSubTree)) :-
    split([Head|Tail], LeftList, [MiddleElem|RightList]),
    balanced_tree_no_sort(LeftList, LeftSubTree),
    balanced_tree_no_sort(RightList, RightSubTree), !.

balanced_tree([Head|Tail], instant(Root, LeftSubTree, RightSubTree)) :-
    qsort([Head|Tail], SortedList),
    split(SortedList, LeftList, [MiddleElem|RightList]),
	Root = MiddleElem,
    balanced_tree_no_sort(LeftList, LeftSubTree),
    balanced_tree_no_sort(RightList, RightSubTree), !.
	
%	?- balanced_tree([2, 0, -3, -1, 21, 6, 7], T).
%	T = instant(2, instant(-1, instant(-3, empty, empty), instant(0, empty, empty)), 
%			instant(7, instant(6, empty, empty), instant(21, empty, empty))).