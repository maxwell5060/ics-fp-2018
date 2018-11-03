% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

internalSplit(Center,Index, Left, Right, NewLeft, NewRight) :-
	Index >= Center,
	NewLeft = Left,
	NewRight = Right.

internalSplit(Center,Index, Left, Right, NewLeft, NewRight) :-
	Index < Center,
	Right = [Head | Tail],
	append(Left,[Head],NewLeft2),
	internalSplit(Center,Index+1,NewLeft2,Tail,NewLeft,NewRight).

split(L, Center, Left, Right) :-
	internalSplit(Center, 0, [], L, Left, Right), !.

empty.

instant(R, empty, empty) :- integer(R), !.

instant(R, LS, empty) :- integer(R), instant(LS,LS2,RS2).

instant(R,empty, RS) :- integer(R), instant(RS,LS2,RS2).

instant(R, LS, RS) :- integer(R), instant(LS,LS2,RS2), instant(RS,LS3,RS3).

balanced_tree([],empty).

balanced_tree(L,T) :-
	integer(L),
	T = instant(L,empty,empty),!.

balanced_tree(L,T) :-
	qsort(L,SortedL),
	SortedL = [Head | Tail],
	Tail = [],
	balanced_tree(Head,T), !.

balanced_tree(L,T) :-
	qsort(L,SortedL),
	SortedL = [Head | Tail],
	Tail = [Center | End],
	End = [],
	balanced_tree(Head,LT),
	T = instant(Center,LT,empty), !.

balanced_tree(L,T) :-
	qsort(L,SortedL),
	SortedL = [Head | Tail],
	Tail = [Center | End],
	End = [EndInt | Empty],
	Empty = [],
	balanced_tree(Head,LT),
	balanced_tree(EndInt,RT),
	T = instant(Center,LT,RT), !.

balanced_tree(L,T) :-
	length(L, Size),
	Size > 3,
	qsort(L,SortedL),
	Center is Size/2 - 1,
	split(SortedL,Center,LS,RS),
	RS = [Root | Tail],
	balanced_tree(LS, LT),
	balanced_tree(Tail, RT),
	T = instant(Root,LT,RT).

getRoot(instant(R,LS,RS),R).

getRoot(empty,empty).

findAllRootsOnLevelN(T,N,CurrentList,ResultList) :-
	N < 1,
	getRoot(T,R),
	append(CurrentList,[R], ResultList), !.

findAllRootsOnLevelN(empty,N,CurrentList,ResultList) :-
	append(CurrentList,["_","_"], ResultList), !.
	

findAllRootsOnLevelN(T,N,CurrentList,ResultList) :-
	N >= 1,
	T = instant(R, LS, RS),
	findAllRootsOnLevelN(LS, N-1, CurrentList, ListWithLeftRoots),
	findAllRootsOnLevelN(RS, N-1, ListWithLeftRoots, ResultList).
	
treeHeight(empty, CurrentHeight, CurrentHeight).

treeHeight(T, CurrentHeight, Height) :-
	T = instant(R, LS, RS),
	NewHeight is CurrentHeight + 1,
	treeHeight(LS, NewHeight, LeftHeight),
	treeHeight(RS, NewHeight, RightHeight),
	LeftHeight >= RightHeight,
	Height = LeftHeight, !.	

treeHeight(T, CurrentHeight, Height) :-
	T = instant(R, LS, RS),
	NewHeight is CurrentHeight + 1,
	treeHeight(LS, NewHeight, LeftHeight),
	treeHeight(RS, NewHeight, RightHeight),
	LeftHeight < RightHeight,
	Height = RightHeight, !.	

printList([],Delimiter) :- !.

printList(L, Delimiter) :-
	L = [Head | Tail],
	write(Head),
	write(Delimiter),
	printList(Tail, Delimiter).

printLevel(T,N, TotalHeight) :-
	N >= TotalHeight,
	findAllRootsOnLevelN(T,N,[],Roots),
	TabsCount is TotalHeight - N,
	printList(Roots," "),
	nl.

printLevel(T, N, TotalHeight) :-
	N < TotalHeight,
	findAllRootsOnLevelN(T,N,[],Roots),
	TabsCount is TotalHeight - N,
	printList(Roots," "),
	nl,
	NextLevel is N + 1,
	printLevel(T,NextLevel,TotalHeight).	

printTree(T) :-
	write("Tree in line notation: "), write(T),nl,
	treeHeight(T,0,Height),
	T = instant(R, LS, RS),
	write("Tree: "), nl,
	printLevel(T,0,Height), !.
	
printBalancedTreeFromList(L) :-
	balanced_tree(L,T),
	printTree(T).

?- printBalancedTreeFromList([9,2,5,7,11,0,-1]).

/*

Output:

Tree in line notation: instant(5,instant(0,instant(-1,empty,empty),instant(2,empty,empty)),instant(9,instant(7,empty,empty),instant(11,empty,empty)))
Tree:
5 
0 9 
-1 2 7 11 
empty empty empty empty empty empty empty empty 

*/

