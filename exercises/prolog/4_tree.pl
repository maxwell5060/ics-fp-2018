% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort(Xs, Ys):- qsort1(Xs, Ys, []).
qsort1([], Ys, Ys).

qsort1([X|Xs], Ys, Zs):-
  partition(Xs, X, Left, Rigth),
  qsort1(Rigth, Ws, Zs),
  qsort1(Left, Ys, [X|Ws]).
  
partition([K|P], X, M, [K|N]):-
  X < K, !,
  partition(P, X, M, N).
  
partition([K|P], X, [K|M], N):-
  partition(P, X, M, N).
  
partition([], _, [], []).

divide(List, L, R) :-
    append(L, R, List),
    length(L, LL),
    length(R, RL),
    (LL =:= RL; LL =:= (RL - 1)), !.

balanced_tree([], empty).
balanced_tree(List, instant(H, empty, empty)) :- 
    List = [H|[]], !.
balanced_tree([Lo|[Hi|[]]], instant(Hi, LNode, empty)) :- 
    Lo < Hi, 
    balanced_tree([Lo], LNode), !.
balanced_tree([Hi|[Lo|[]]], instant(Hi, LNode, empty)) :- 
    balanced_tree([Lo], LNode), !.
balanced_tree(List, instant(Mid, LNode, RNode)) :-
    qsort(List, Sorted),
    divide(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LNode),
    balanced_tree(RightList, RNode), !.

% ?- balanced_tree([8,4,6,7,9,0,2], Tab).
% Tab = instant(6, instant(2, instant(0, empty, empty), instant(4, empty, empty)), instant(8, instant(7, empty, empty), instant(9, empty, empty))).