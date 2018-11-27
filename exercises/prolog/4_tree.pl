% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

divide(_, [], [], []).

divide(Sep, [Head|Tail], [Head|Left], Right):-
	Sep >= Head,
	divide(Sep, Tail, Left, Right).

divide(Sep, [Head|Tail], Left, [Head|Right]):-
	divide(Sep, Tail, Left, Right).

qsort([], []).
qsort(L, K):-
	L = [Head|Tail],
	divide(Head, Tail, Left, Right),
	qsort(Left, SLeft),
	qsort(Right, SRight),
	append(SLeft, [Head|SRight], K).

split(List, Left, Right):-
    append(Left, Right, List),
    length(List, Len),
    HalfLen is Len div 2,
    length(Left, HalfLen).

balanced_tree_impl([], empty).

balanced_tree_impl(List, instant(Root, LeftChild, RightChild)):-
    split(List, LeftList, [Root|RightList]),
    balanced_tree_impl(LeftList, LeftChild),
    balanced_tree_impl(RightList, RightChild).

balanced_tree(L,T):-
	qsort(L, SL),
	balanced_tree_impl(SL,T).

/* Results:

1 ?- balanced_tree([],T).
T = empty .

2 ?- balanced_tree([5],T).
T = instant(5, empty, empty) .

3 ?- balanced_tree([5,4],T).
T = instant(5, instant(4, empty, empty), empty) .

4 ?- balanced_tree([5,6],T).
T = instant(6, instant(5, empty, empty), empty) .

5 ?- balanced_tree([5,6,1,2,3],T).
T = instant(3,
	instant(2,
		instant(1, empty, empty),
		empty),
	instant(6,
		instant(5, empty, empty),
		empty)) .

6 ?- balanced_tree([9,8,1,2,4,10,7,4],T).
T = instant(7,
	instant(4,
		instant(2,
			instant(1, empty, empty),
			empty),
		instant(4, empty, empty)),
	instant(9,
		instant(8, empty, empty),
		instant(10, empty, empty)))

*/