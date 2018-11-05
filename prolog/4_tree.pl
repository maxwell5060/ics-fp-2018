% используя предикат qsort(List,K) из предыдущего задания разработать предикат:
% balanced_tree(List,Tree) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево
% instant(R, List, R) - бинарное дерево с корнем R и двумя поддеревьями List и R соотвественно (левое и правое)

split(_, [], [], []).
split(X, [Head | Body], [Head | Less], Greater)	:- Head =< X, split(X, Body, Less, Greater).
split(X, [Head | Body], Less, [Head | Greater])	:- Head > X, split(X, Body, Less, Greater).

splitList(List, List1, List2)				:- splitList2([_|List], List, List1, List2).
splitList2([_,_|Body], [Head|List], [Head|List1], List2):-!, splitList2(Body, List, List1, List2).
splitList2(_, List2, [], List2).

qsort([],[]).
qsort([Head | Body], Result)	:- split(Head, Body, Less, Greater), qsort(Less, SortedLess), qsort(Greater, SortedGreater), append(SortedLess, [Head | SortedGreater], Result).	

removeLastItem([_|[]],[]).
removeLastItem([Head|Body1],[Head|Body2])	:-removeLastItem(Body1,Body2).
removeLastItem(Body1,Body2)			:-Body1=[], Body2=[].

getLastItem(X, Y) :- X=[], Y=[].
getLastItem(X, Y) :- last(X,Z), Y=[Z].

getItem(List,X) :- splitList(List,List1,_), getLastItem(List1, R), R=X.

put(List1,List2,X,R) :- length(List1,0), length(List2,0), R=X.
put(List1,List2,X,R) :- getItem(List1,X1), getItem(List2,X2), append(X,X1,R1), append(R1,X2,R2),
splitList(List1,List1A,List1B), removeLastItem(List1A,List1C), put(List1C, List1B, R2, R3),
splitList(List2,List2A,List2B), removeLastItem(List2A,List2C), put(List2C, List2B, R3, R4), R=R4.

getlist(List,Y):-R=[], getItem(List,X), 
			append(R,X,R2), 
			splitList(List,List1,List2), 
			removeLastItem(List1,List1A), 
			put(List1A, List2, R2, R3), Y=R3.

addNode(X,empty,Tree) :- Tree = instant(X,empty,empty).
addNode(X,instant(Root,List,R),Tree) 	:- X @< Root, Tree = instant(Root,List1,R), addNode(X,List,List1).
addNode(X,instant(Root,List,R),Tree) 	:- X @> Root, Tree = instant(Root,List,R1), addNode(X,R,R1).
balanced_tree(List,Tree) :- qsort(List, S), getlist(S, List2), balanced_tree(List2,Tree,empty).
balanced_tree([],Tree,TreeA) :- Tree = TreeA.
balanced_tree([N|Ms],Tree,TreeA) :- addNode(N,TreeA,TreeB), balanced_tree(Ms,Tree,TreeB).


% ========================================
% balanced_tree([2,4,6,10,13,20],Tree).
% Tree = instant(6, instant(2, empty, instant(4, empty, empty)), instant(13, instant(10, empty, empty), instant(20, empty, empty))) 