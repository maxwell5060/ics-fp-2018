% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

leftArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD =< PIVOT, leftArray(PIVOT,TAIL,INRESULT), append([HEAD],INRESULT,RESULT),!.
leftArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD > PIVOT, leftArray(PIVOT,TAIL,INRESULT), append([],INRESULT,RESULT),!.
leftArray(PIVOT,[HEAD|TAIL],[]) :- length(TAIL,L), L == 0,!.

rightArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD > PIVOT, rightArray(PIVOT,TAIL,INRESULT), append([HEAD],INRESULT,RESULT),!.
rightArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD =< PIVOT, rightArray(PIVOT,TAIL,INRESULT), append([],INRESULT,RESULT),!.
rightArray(PIVOT,[HEAD|TAIL],[]) :- length(TAIL,L), L == 0,!.

qsort(ARRAY,ARRAY) :- length(ARRAY,1),!.
qsort([],[]).

qsort(ARRAY,RESULT) :- last(ARRAY,PIVOT), leftArray(PIVOT,ARRAY,LEFTARRAY), rightArray(PIVOT,ARRAY,RIGHTARRAY), qsort(LEFTARRAY,LEFTRESULT), qsort(RIGHTARRAY,RIGHTRESULT), append(LEFTRESULT,[PIVOT],PROMRESULT), append(PROMRESULT,RIGHTRESULT,RESULT),!.



divide(LIST,L,R,N):- length(LIST,LEN), I is (LEN - 1) div 2, div(LIST,L,R,N,I),!.
divide([H|T],L,R,N):- T==[], L =[], R=[], N=H,!.
divide([H|[T|TT]],L,R,N):- TT==[], L =[], R=[H], N=T,!.
div([H|[T|TT]],L,R,N,1):- L = [H], R = TT, N = T,!.
div([H|T],L,R,N,I):- I\=0, II is I - 1, append([H],ARR,L), div(T,ARR,R,N,II),!.

tree([],empty).
tree(LIST,T):- divide(LIST,LEFT,RIGHT,NODE), tree(LEFT,LT), tree(RIGHT,RT), T=instant(NODE,LT,RT). 
balanced_tree(L,T) :- qsort(L,RESULT), tree(RESULT,T).

?- balanced_tree([],T).
T = empty .

?- balanced_tree([1],T).
T = instant(1, empty, empty) .

?- balanced_tree([1,2],T).
T = instant(2, empty, instant(1, empty, empty)) .

?- balanced_tree([5,3,6,2,1,7,4],T).
T = instant(4, instant(2, instant(1, empty, empty), instant(3, empty, empty)), instant(6, instant(5, empty, empty), instant(7, empty, empty))) .