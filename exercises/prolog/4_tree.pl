% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

quicksort([H|T],X) :-
	partition(H,T,Left,Right),
	quicksort(Left,S1),
	quicksort(Right,S2),
	append(S1,[H|S2],X).

quicksort([],[]).

partition(Pivot,[H|T],[H|Rest],RightSide) :- H =< Pivot, partition(Pivot,T,Rest,RightSide).
partition(Pivot,[H|T],LeftSide,[H|Rest]) :- H > Pivot, partition(Pivot,T,LeftSide,Rest).
partition(_,[],[],[]).

divide(List, L, R) :- append(L, R, List), length(L, LL), length(R, RL), (LL =:= RL; LL =:= (RL - 1)), !.

balanced_tree([], empty).
balanced_tree(List, instant(H, empty, empty)) :- List = [H|[]], !.
balanced_tree([Lo|[Hi|[]]], instant(Hi, LNode, empty)) :- Lo < Hi, balanced_tree([Lo], LNode), !.
balanced_tree([Hi|[Lo|[]]], instant(Hi, LNode, empty)) :- balanced_tree([Lo], LNode), !.
balanced_tree(List, instant(Mid, LNode, RNode)) :-
    quicksort(List, Sorted),
    divide(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LNode),
    balanced_tree(RightList, RNode), !.