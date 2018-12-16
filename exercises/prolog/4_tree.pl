% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort(L,K):-
		L = [Head|Tail],
		partition(Head, Tail, List1, List2),
		qsort(List1, Sorted1),
		qsort(List2, Sorted2),
		append(Sorted1, [Head|Sorted2], K).

qsort([], []).

partition(Current, [Head|Tail], [Head|LowEq], High):-
		Current >= Head,
		partition(Current, Tail, LowEq, High).

partition(Current, [Head|Tail], LowEq, [Head|High]):-
		partition(Current, Tail, LowEq, High).

partition(_, [], [], []).

split(List, Left, Right):-
	append(Left, Right, List),
	length(List, Len),
	Half is Len  div 2,
	length(Left, Half).

balanced_tree_impl([], empty).
balanced_tree_impl(List, instant(Root, LeftLeef, RightLeef)):-
	split(List, LeftList, [Root|RightList]),
	balanced_tree_impl(LeftList, LeftLeef),
	balanced_tree_impl(RightList, RightLeef). 

balanced_tree(L, T):-
	qsort(L, SL),
	balanced_tree_impl(SL, T).

run:-
	Empty_list = [],
	L1 = [5],
	L2 = [5,4],
	L3 = [5,4,6],
	L4 = [5, 11, 4, 2, 6, 9, 7, 5, 2],
	writeln(Empty_list),
	balanced_tree(Empty_list,R0),
	writeln(R0), nl,
	writeln(L1),
	balanced_tree(L1,R1),
	writeln(R1), nl,
	writeln(L2),
	balanced_tree(L2,R2),
	writeln(R2), nl,
	writeln(L3),
	balanced_tree(L3,R3),
	writeln(R3), nl,
	writeln(L4),
	balanced_tree(L4,R4),
	writeln(R4).

% ?- run.
% []
% empty

% [5]
% instant(5,empty,empty)

% [5,4]
% instant(5,instant(4,empty,empty),empty)

% [5,4,6]
% instant(5,instant(4,empty,empty),instant(6,empty,empty))

% [5,11,4,2,6,9,7,5,2]
% instant(5,instant(4,instant(2,instant(2,empty,empty),empty),instant(5,empty,empty)),instant(9,instant(7,instant(6,empty,empty),empty),instant(11,empty,empty)))
% true .