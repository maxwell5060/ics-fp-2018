% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

partition([E|Elist],Y,[E|Hlist],Tlist) :-
   E =< Y, partition(Elist,Y,Hlist,Tlist).
partition([E|Elist],Y,Hlist,[E|Tlist]) :-
   E > Y, partition(Elist,Y,Hlist,Tlist).
partition([], _,[],[]).

qsort([],[]).
qsort([E|Elist], K) :-
   partition(Elist, E, Head, Tail),
   qsort(Head, Hlist),
   qsort(Tail, Tlist),
   append(Hlist, [E|Tlist], K).

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

% balanced_tree([6,10,23,42,1,101,202,2],T).
% T = instant(23, instant(6, instant(2, instant(1, empty, empty), empty), instant(10, empty, empty)), instant(101, instant(42, empty, empty), instant(202, empty, empty)))