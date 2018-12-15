% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort([],[]).
qsort([Head|Tail],Sorted) :-
	partition(Head,Tail,Little,Big),
	qsort(Little,SortedLittle),
	qsort(Big,SortedBig),
	append(SortedLittle,[Head|SortedBig],Sorted).

partition(_,[],[],[]).
partition(Pivot,[Head|Tail], [Head|Little], Big) :-
	Head =< Pivot, partition(Pivot,Tail,Little,Big).

partition(Pivot,[Head|Tail], Little, [Head|Big]) :-
	partition(Pivot,Tail,Little,Big).
balanced_tree([], empty).
balanced_tree(List, Tree) :- 
	qsort(List, SortedList),
	list2tree(SortedList, Tree).
list2tree([],empty).
list2tree(List, instant(Root, Left, Right)) :- 
	divide(List, LeftPart, [Root | RightPart]),
	list2tree(LeftPart, Left),
	list2tree(RightPart, Right).
divide(List, LeftPart, RightPart) :-
	append(LeftPart, RightPart, List),
	length(List, ListLength),
	Mid is ListLength div 2,
	length(LeftPart, Mid).

%?- balanced_tree([7,0,-1,10,6,-3,1,7],Tree).
%Tree = instant(6, 
%	  instant(0, 
%		  instant(-1, 
%			instant(-3, empty, empty), empty),
%	          instant(1, empty, empty)),
%	   instant(7,
%	  	  instant(7, empty, empty),
%		  instant(10, empty, empty))) 
