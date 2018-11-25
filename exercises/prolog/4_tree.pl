% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

--------------------------------------------------------------------------------------------------
qsort([],[]).
qsort([X|Xs],Ys) :-
  partition(Xs,X,Left,Right),
  qsort(Left,Ls),
  qsort(Right,Rs),
  append(Ls,[X|Rs],Ys).

partition([X|Xs],Y,[X|Ls],Rs) :- X =< Y, partition(Xs,Y,Ls,Rs).
partition([X|Xs],Y,Ls,[X|Rs]) :- X > Y, partition(Xs,Y,Ls,Rs).
partition([],Y,[],[]).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).

splitInMiddle(List, Less, More) :-
    append(Less, More, List),
    length(Less, LessLength),
    length(More, MoreLength),
    (LessLength =:= MoreLength; LessLength =:= (MoreLength - 1)), !.

balanced_tree([], empty).

balanced_tree(List, instant(Head, empty, empty)) :-
    List = [Head|[]], !.

balanced_tree([Head|[Body|[]]], instant(Body, LessChild, empty)) :-
    Head < Body,
    balanced_tree([Body], LessChild), !.

balanced_tree([Head|[Body|[]]], instant(Head, LessChild, empty)) :-
    balanced_tree([Body], LessChild), !.

balanced_tree(List, instant(Mid, LessChild, MoreChild)) :-
    qsort(List, Sorted),
    splitInMiddle(Sorted, LessList, [Mid|MoreList]),
    balanced_tree(LessList, LessChild),
balanced_tree(MoreList, MoreChild), !.




