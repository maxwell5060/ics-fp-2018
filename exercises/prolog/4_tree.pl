% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

pivot(_, [], [], []).
pivot(Pivot, [Head|Tail], [Head|LessOrEqualThan], GreaterThan) :-
    Pivot >= Head, pivot(Pivot, Tail, LessOrEqualThan, GreaterThan).
pivot(Pivot, [Head|Tail], LessOrEqualThan, [Head|GreaterThan]) :-
    pivot(Pivot, Tail, LessOrEqualThan, GreaterThan).

qsort([], []).
qsort([Head|Tail], Sorted) :-
    pivot(Head, Tail, List1, List2),
    qsort(List1, SortedList1),
    qsort(List2, SortedList2),
    append(SortedList1, [Head|SortedList2], Sorted).


same_length(List1,List2) :-
	length(List1, Length1),
	length(List2, Length2),
	(Length1 =:= Length2;
	Length1 =:= (Length2 - 1)).

divide(List, LeftList, RightList) :-
	append(LeftList, RightList, List),
	same_length(LeftList, RightList), !.


balanced_tree_without_sort([], empty).

balanced_tree_without_sort(List, instant(Root, empty, empty)) :-
	List = [Root|[]], !.

balanced_tree_without_sort([First, Second], instant(Second, Left, empty)) :-
	First < Second,
	balanced_tree([First], Left), !.

balanced_tree_without_sort([First, Second], instant(First, Left, empty)) :-
	First >= Second,
	balanced_tree([Second], Left), !.

balanced_tree_without_sort(SortedList, instant(Mid, Left, Right)) :-
	divide(SortedList, LeftList, [Mid|RightList]),
	balanced_tree_without_sort(LeftList, Left),
	balanced_tree_without_sort(RightList, Right), !.

balanced_tree(List, instant(Mid, Left, Right)) :-
	qsort(List, Sorted),
	divide(Sorted, LeftList, [Mid|RightList]),
	balanced_tree_without_sort(LeftList, Left),
balanced_tree_without_sort(RightList, Right), !.
