% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort([],[]).
qsort([X|Xs],Ys) :-
partition(Xs,X,Left,Right),
qsort(Left,Ls),
qsort(Right,Rs),
append(Ls,[X|Rs],Ys).

partition([X|Xs],Y,[X|Ls],Rs):- X =< Y, partition(Xs,Y,Ls,Rs).
partition([X|Xs],Y,Ls,[X|Rs]):- X > Y, partition(Xs,Y,Ls,Rs).
partition([],_,[],[]).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).



split(Lt, Ls, Mr) :-
append(Ls, Mr, Lt),
length(Ls, LsLng),
length(Mr, MrLng),
(LsLng =:= MrLng; LsLng =:= (MrLng - 1)), !.
balanced_tree([], none).
balanced_tree(Lt, instant(Hd, none, none)) :- Lt = [Hd|[]], !.
balanced_tree([Hd|[Tl|[]]], instant(Tl, LsCh, none)) :-
Hd < Tl,
balanced_tree([Tl], LsCh), !.
balanced_tree([Hd|[Tl|[]]], instant(Hd, LsCh, none)) :-
balanced_tree([Tl], LsCh), !.
balanced_tree(Lt, instant(Md, LsCh, MrCh)) :-
qsort(Lt, Sd),
split(Sd, LsLt, [Md|MrLt]),
balanced_tree(LsLt, LsCh),
balanced_tree(MrLt, MrCh), !.
