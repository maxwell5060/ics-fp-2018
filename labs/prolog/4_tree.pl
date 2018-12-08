% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
qsort([],[]).
qsort([Head|Tail],Sorted) :-
	partition(Head,Tail,Smaller,Bigger),
	qsort(Smaller,SortedSmaller),
	qsort(Bigger,SortedBigger),
	append(SortedSmaller,[Head|SortedBigger],Sorted).
partition(_,[],[],[]).
partition(Pivot,[Head|Tail], [Head|Smaller], Bigger) :-
	Head =< Pivot, partition(Pivot,Tail,Smaller,Bigger).
partition(Pivot,[Head|Tail], Smaller, [Head|Bigger]) :-
	partition(Pivot,Tail,Smaller,Bigger).

% если пустой список
balanced_tree([], empty).

% если у нас сортированный список
balanced_tree(List,Tree) :- 
	qsort(List, SortedList),
	list2tree(SortedList, Tree).
% если пустой список
list2tree([],empty).


list2tree(List, instant(Root, L, R)) :- 
	divide(List, LList, [Root | RList]),
	list2tree(LList, L),
	list2tree(RList, R).
divide(List, LList, RList) :-
	append(LList, RList, List),
	length(List, ListLength),
	Mid is ListLength div 2,
	length(LList, Mid).

%?- balanced_tree([6,2,0,13,5,-1,3,6],Tree).
%Tree = instant(5, 
%	  instant(2, 
%		  instant(0, 
%			instant(-1, empty, empty), empty),
%	          instant(3, empty, empty)),
%	   instant(6,
%	  	  instant(6, empty, empty),
%		  instant(13, empty, empty))) 
